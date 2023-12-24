import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/config/router/app_router.dart';
import 'package:la_carreta_express_cs/config/theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'La Carreta Express App',
      routerConfig: AppRouter.appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}