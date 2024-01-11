import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/presentation/widgets/home/custom_drawer.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {   

  static const String name = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: _HomeView(),      
      drawer: CustomDrawer(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*Drawer and Cart Button
          DrawerCartSection(),

          SizedBox(height: 20),

          //* Badge Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CardPresentationHome(imgUrl: "assets/home/badge.png", personUrl: "assets/home/Chef-Badge.png"),
          ),

          SizedBox(height: 20),

          //* Categorias
          Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10),
            child: Text("Categorias", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),),
          ),          

          //* Lista de Categorias
          ListCategorias(),
          SizedBox(height: 10),

          //* Mas populares
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Más populares", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),),
          ),  

          SizedBox(height: 10),

          //* Listado de platos
          ListPlatos(),

          //* Marca registrada
          Spacer(),
          RegisteredTradeMark()          
        ],
      ),
    );
  }
}

