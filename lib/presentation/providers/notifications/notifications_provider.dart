import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/push_message.dart';
import 'package:la_carreta_express_cs/infraestructure/http/authenticated_api_client.dart';

enum AuthorizationStatus { notDetermined, authorized }

final notificationsProvider =
    StateNotifierProvider<NotificationsProvider, NotificationsState>((ref) {
  return NotificationsProvider();
});

class NotificationsProvider extends StateNotifier<NotificationsState> {
  NotificationsProvider() : super(const NotificationsState()) {
    _refresh();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => _refresh());
  }

  Timer? _timer;

  void requestPermission() {
    state = state.copyWith(status: AuthorizationStatus.authorized);
  }

  Future<void> _refresh() async {
    if (ApiClient.tenantId.isEmpty || ApiClient.instance.accessToken == null) {
      return;
    }
    try {
      final response = await ApiClient.instance.request(
        'GET',
        '/customer/tenants/${ApiClient.tenantId}/notifications',
      ) as List<dynamic>;
      final notifications = response.map((raw) {
        final item = raw as Map<String, dynamic>;
        final payload = item['payload'] as Map<String, dynamic>? ?? const {};
        return PushMessage(
          messageId: item['id'] as String,
          title: item['templateKey']?.toString() ?? 'Actualización del pedido',
          body: payload['message']?.toString() ?? 'Tu pedido cambió de estado',
          sentDate: DateTime.tryParse(item['createdAt']?.toString() ?? '') ??
              DateTime.now(),
          data: Map<String, dynamic>.from(payload),
        );
      }).toList();
      state = state.copyWith(notifications: notifications);
    } catch (_) {
      // The order timeline remains available even if polling temporarily fails.
    }
  }

  PushMessage? getMessageById(String pushMessageId) {
    for (final notification in state.notifications) {
      if (notification.messageId == pushMessageId) return notification;
    }
    return null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class NotificationsState {
  final AuthorizationStatus status;
  final List<PushMessage> notifications;

  const NotificationsState({
    this.status = AuthorizationStatus.notDetermined,
    this.notifications = const [],
  });

  NotificationsState copyWith({
    AuthorizationStatus? status,
    List<PushMessage>? notifications,
  }) =>
      NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
      );
}
