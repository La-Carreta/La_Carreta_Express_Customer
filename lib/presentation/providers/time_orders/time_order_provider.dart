import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/estimated_time.dart';
import 'package:la_carreta_express_cs/presentation/providers/orden_pedido/orden_pedido_repository_provider.dart';

//! 3 - StateNotifierProvider - consume afuera
final timeOrderProvider =
    StateNotifierProvider<EstimatedTimeNotifier, EstimatedTime>((ref) {
  final getTimeEstimated =
      ref.watch(ordenPedidoRepositoryProvider).getEstimatedTime;
  return EstimatedTimeNotifier(callbackOnEstimatedTime: getTimeEstimated);
});

typedef CallbackOnEstimatedTime = Future<EstimatedTime> Function();

//! 2 - Como implementamos un notifier
class EstimatedTimeNotifier extends StateNotifier<EstimatedTime> {
  final CallbackOnEstimatedTime callbackOnEstimatedTime;
  bool isLoading = false;

  EstimatedTimeNotifier({required this.callbackOnEstimatedTime})
      : super(EstimatedTime.empty());

  Future<void> getEstimatedTime() async {
    if (isLoading) return;
    isLoading = true;
    final estimatedTime = await callbackOnEstimatedTime();
    state = state.copyWith(
        numHoras: estimatedTime.numHoras,
        numMinutos: estimatedTime.numMinutos,
        tiempoEstimado: estimatedTime.tiempoEstimado);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
