import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/config/router/app_router.dart';
import 'package:la_carreta_express_cs/config/theme/app_theme.dart';
import 'package:la_carreta_express_cs/firebase_options.dart';
import 'package:la_carreta_express_cs/presentation/providers/notifications/notifications_provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'La Carreta Express App',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      builder: (context, child) => HandleNotificationInteractions(child: child!),
    );
  }
}

class HandleNotificationInteractions extends ConsumerStatefulWidget {

  final Widget child;
  const HandleNotificationInteractions({super.key, required this.child});

  @override
  HandleNotificationInteractionsState createState() => HandleNotificationInteractionsState();
}

class HandleNotificationInteractionsState extends ConsumerState<HandleNotificationInteractions> {

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    ref.read(notificationsProvider.notifier)
      .handleRemoteMessage(message);

    final appRouter = ref.watch(goRouterProvider);

    appRouter.push("/seguimiento-pedido/${message.data['ordenId']}");
  }


  @override
  void initState() {
    super.initState();

    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}