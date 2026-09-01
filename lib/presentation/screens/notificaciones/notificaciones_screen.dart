import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/domain/entities/push_message.dart';
import 'package:la_carreta_express_cs/presentation/providers/notifications/notifications_provider.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class NotificacionesScreen extends StatelessWidget {
  static String name = 'notificaciones_screen';

  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        //Background
        const ImageBackground(imgUrl: "assets/background/main.png"),

        //Back button
        const Positioned(top: 50, left: 20, child: CustomBackButton()),

        //Title
        Positioned(
            top: 55,
            left: size.width * 0.30, //150
            child: const Text(
              "Notificaciones",
              style: TextStyle(fontSize: 30, color: Colors.white),
            )),

        Positioned(
            bottom: 0,
            left: 0,
            child: _NotificacionesView(
              maximiunHeight: size.height * 0.85,
              maximiunWidth: size.width,
            )),
      ],
    ));
  }
}

class _NotificacionesView extends ConsumerWidget {
  final double maximiunHeight;
  final double maximiunWidth;

  const _NotificacionesView({
    required this.maximiunHeight,
    required this.maximiunWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsState = ref.watch(notificationsProvider);
    final notifications = notificationsState.notifications;

    return Container(
      width: maximiunWidth,
      height: maximiunHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(25)),
      ),
      child: notifications.isEmpty
          ? const Center(
              child: Text(
              "No tienes notificaciones",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ))
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _Notification(
                  maximiunWidth: maximiunWidth,
                  notification: notification,
                );
              },
            ),
    );
  }
}

class _Notification extends StatelessWidget {
  final double maximiunWidth;
  final PushMessage notification;

  const _Notification({
    required this.maximiunWidth,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffe9ecef))),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                  notification.imageUrl != null
                      ? notification.imageUrl!
                      : "https://res.cloudinary.com/dwexseytn/image/upload/v1703805014/La_Carreta_Express/Various_icons/order_1_mzglvm.png",
                  width: 60,
                  fit: BoxFit.cover)),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notification.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(notification.body)
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () => context.push(
                  "/seguimiento-pedido/${notification.data?['ordenId'] ?? "no-id"}"),
              icon: const Icon(
                Icons.chevron_right_outlined,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
