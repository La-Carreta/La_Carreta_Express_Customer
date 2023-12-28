import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class SeguimientoPedidoScreen extends StatelessWidget {
  static const String name = 'seguimiento_pedido_screen';
  const SeguimientoPedidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const ImageBackground(imgUrl: "assets/background/main.png"),

          //Back button
          const Positioned(
            top: 50,
            left: 20,
            child: CustomBackButton()
          ),

          
          //Title
          Positioned(
            top: 55,
            left: size.width * 0.25,//150
            child: const Text("Seguimiento del Pedido", style: TextStyle(fontSize: 27, color: Colors.white),)
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: _SiguimientoPedidoView(maximiunHeight: size.height * 0.85, maximiunWidth: size.width,)
          ),
        ],
      ),
    );
  }
}

class _SiguimientoPedidoView extends StatelessWidget {
  final double maximiunHeight;
  final double maximiunWidth;

  const _SiguimientoPedidoView({
    required this.maximiunHeight, required this.maximiunWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maximiunWidth,
      height: maximiunHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [          

        ],
      ),
    );
  }

}