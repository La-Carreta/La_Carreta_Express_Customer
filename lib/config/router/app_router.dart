import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/presentation/screens/screens.dart';

class AppRouter{
  static final appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: "/",
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen()
      ),

      GoRoute(
        path: "/sign-in",
        name: SignInScreen.name,
        builder: (context, state) => const SignInScreen()
      ),

      GoRoute(
        path: "/sign-up",
        name: SignUpScreen.name,
        builder: (context, state) => const SignUpScreen()
      ),

      GoRoute(
        path: "/reset-password",
        name: ResetPasswordScreen.name,
        builder: (context, state) => const ResetPasswordScreen()
      ),

      GoRoute(
        path: "/info-plato",
        name: InfoPlatoScreen.name,
        builder: (context, state) => const InfoPlatoScreen()
      ),

      GoRoute(
        path: "/cart",
        name: CartScreen.name,
        builder: (context, state) => const CartScreen()
      ),

      GoRoute(
        path: "/pedidos",
        name: PedidosScreen.name,
        builder: (context, state) => const PedidosScreen()
      ),

      GoRoute(
        path: "/seguimiento-pedido",
        name: SeguimientoPedidoScreen.name,
        builder: (context, state) => const SeguimientoPedidoScreen()
      ),
    ]
  );

}