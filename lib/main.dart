import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/config/provider/app_provider.dart';
import 'package:la_carreta_express_cs/config/router/app_router.dart';
import 'package:la_carreta_express_cs/config/theme/app_theme.dart';
import 'package:la_carreta_express_cs/infraestructure/datasources/detalle_orden_pedido_datasource_imp.dart';
import 'package:la_carreta_express_cs/infraestructure/repositories/detalle_orden_pedido_repository_imp.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    final detOrdRepository = DetalleOrdenPedidoRepositoryImp(
      detalleOrdenPedidoDataSource: DetallePedidoDataSourceImp()
    );

    return MultiProvider(
      providers: AppProvider.getProvider(detOrdRepository),
      child: const MyApp()
    );
  }
}

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