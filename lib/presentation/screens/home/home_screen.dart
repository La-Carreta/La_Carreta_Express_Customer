import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/presentation/providers/auth/auth_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/customer/customer_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/notifications/notifications_provider.dart';
import 'package:la_carreta_express_cs/presentation/widgets/home/custom_drawer.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();
    ref.watch(customerProvider.notifier).getCustomerById(user.user?.id ?? "");
    ref.watch(notificationsProvider.notifier).requestPermission();

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: const _HomeView(),
      drawer: CustomDrawer(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*Drawer and Cart Button
          FadeInRight(from: 50, child: const DrawerCartSection()),

          const SizedBox(height: 20),

          //* Badge Card
          FadeInDown(
            from: 50,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: CardPresentationHome(
                  imgUrl: "assets/home/badge.png",
                  personUrl: "assets/home/Chef-Badge.png"),
            ),
          ),

          const SizedBox(height: 20),

          //* Categorias
          FadeInLeft(
            child: const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "Categorias",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
            ),
          ),

          //* Lista de Categorias
          FadeInRight(child: const ListCategorias()),
          const SizedBox(height: 10),

          //* Mas populares
          FadeInLeft(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Más populares",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
            ),
          ),

          const SizedBox(height: 10),

          //* Listado de platos
          FadeInRight(child: const ListPlatos()),

          //* Marca registrada
          const Spacer(),
          const RegisteredTradeMark()
        ],
      ),
    );
  }
}
