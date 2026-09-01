import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/config/router/app_router_notifier.dart';
import 'package:la_carreta_express_cs/presentation/providers/auth/auth_provider.dart';
import 'package:la_carreta_express_cs/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/checking',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/checking',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
          path: "/login",
          name: LoginScreen.name,
          builder: (context, state) => const LoginScreen()),
      GoRoute(
          path: "/register",
          name: RegisterScreen.name,
          builder: (context, state) => const RegisterScreen()),
      GoRoute(
          path: "/reset-password",
          name: ResetPasswordScreen.name,
          builder: (context, state) => const ResetPasswordScreen()),
      GoRoute(
        path: "/",
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
          path: "/info-plato/:id",
          name: InfoPlatoScreen.name,
          builder: (context, state) {
            final platoId = state.pathParameters['id'] ?? "no-id";
            return InfoPlatoScreen(platoId: platoId);
          }),
      GoRoute(
          path: "/cart",
          name: CartScreen.name,
          builder: (context, state) => const CartScreen()),
      GoRoute(
          path: "/pedidos",
          name: PedidosScreen.name,
          builder: (context, state) => const PedidosScreen()),
      GoRoute(
          path: "/seguimiento-pedido/:id",
          name: SeguimientoPedidoScreen.name,
          builder: (context, state) {
            final idPedido = state.pathParameters['id'] ?? "no-id";
            return SeguimientoPedidoScreen(idPedido: idPedido);
          }),
      GoRoute(
          path: "/detalle-pedido/:id",
          name: DetallePedidoScreen.name,
          builder: (context, state) {
            final idPedido = state.pathParameters['id'] ?? "no-id";
            return DetallePedidoScreen(
              idPedido: idPedido,
            );
          }),
      GoRoute(
          path: "/notificaciones",
          name: NotificacionesScreen.name,
          builder: (context, state) => const NotificacionesScreen()),
      GoRoute(
          path: "/account-user",
          name: AccountUserScreen.name,
          builder: (context, state) => const AccountUserScreen()),
      GoRoute(
          path: "/order-success",
          name: OrderSuccessScreen.name,
          builder: (context, state) => const OrderSuccessScreen()),
    ],
    redirect: (context, state) {
      final isGoingTo = state.fullPath;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/checking' && authStatus == AuthStatus.checking) {
        return null;
      }
      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == "/reset-password") {
          return null;
        }

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == "/checking") {
          return '/';
        }
      }

      return null;
    },
  );
});
