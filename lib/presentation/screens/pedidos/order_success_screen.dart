import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessScreen extends StatelessWidget {

  static const String name = "/order-success"; 
  const OrderSuccessScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -250,
            left: 0,
            child: Transform.rotate(
              angle: 1.0,
              child: Container(
                width: 300,
                height: 700,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background/order-bg.png"),                    
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
    
          const _OrderSuccessView(),
        ],
      ),
    );
  }
}

class _OrderSuccessView extends StatelessWidget {
  const _OrderSuccessView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/json/order-success.json', width: 200, height: 200),
            const Text("Pedido con éxito", style: TextStyle(fontSize: 30),),
            const Text("Tu pedido ha sido realizado con éxito. En breve, un mesero se acercará a confirmar tu orden.", textAlign: TextAlign.center, style: TextStyle(fontSize: 17)),
            const SizedBox(height: 20),
    
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
                textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 15, color: Colors.white )),
                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),                
              ),
              onPressed: () {
                context.go("/");
              },
              child: const Text("Volver al inicio", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}