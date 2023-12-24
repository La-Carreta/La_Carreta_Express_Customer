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

      // GoRoute(
      //   path: "/buttons",
      //   name: ButtonsScreen.name,
      //   builder: (context, state) => const ButtonsScreen()
      // ),

      // GoRoute(
      //   path: "/cards",
      //   name: CardsScreen.name,
      //   builder: (context, state) => const CardsScreen()
      // ),
    ]
  );

}