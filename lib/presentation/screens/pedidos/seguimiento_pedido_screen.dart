import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:google_fonts/google_fonts.dart';

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
          //Time Box
          const _EstimatedTimeBox(),

          const SizedBox(height: 10),

          //Linea de tiempo
          const _TimeLinePedido(),

          const SizedBox(height: 10),

          //Boton de detalles de pedido
          FilledButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(300, 40)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
              backgroundColor: MaterialStateProperty.all(const Color(0xFFe9ecef))
            ),
            onPressed: ()=> context.push("/detalle-pedido"), 
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Detalles del pedido", style: TextStyle(color: Colors.black, fontSize: 15),),   
                Icon(Icons.chevron_right, color: Colors.black,)         
              ],
            )
          ),
          const SizedBox(height: 10),
          const Text("NOTA:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          const Text("El tiempo de estimación se calcula en base a los pedidos realizados en orden de llegada al sistema.", style: TextStyle(fontSize: 15), textAlign: TextAlign.justify,)

        ],
      ),
    );
  }

}

class _TimeLinePedido extends StatelessWidget {
  const _TimeLinePedido({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TimelineTile(
              isFirst: true,
              lineXY: 0.1,
              alignment: TimelineAlign.start,
              indicatorStyle: const IndicatorStyle(
                width: 20,
                color: Color(0xFF27AA69),
                padding: EdgeInsets.all(6),
              ),
              endChild: const _RightChild(
                asset: 'assets/pedidos-icons/order_placed.png',
                title: 'Pedido realizado',
                message: 'Hemos recibido su pedido.',
              ),
              beforeLineStyle: const LineStyle(
                color: Color(0xFF27AA69),
              ),
            ), 
      
            TimelineTile(
              alignment: TimelineAlign.start,
              lineXY: 0.1,
              indicatorStyle: const IndicatorStyle(
                width: 20,
                color: Color(0xFF27AA69),
                padding: EdgeInsets.all(6),
              ),
              endChild: const _RightChild(
                asset: 'assets/pedidos-icons/order_confirmed.png',
                title: 'Pedido confirmado',
                message: 'Tu pedido ha sido confirmado.',
              ),
              beforeLineStyle: const LineStyle(
                color: Color(0xFF27AA69),
              ),
            ),        
      
            TimelineTile(
              alignment: TimelineAlign.start,
              lineXY: 0.1,
              indicatorStyle: const IndicatorStyle(
                width: 20,
                color: Color(0xFF2B619C),
                padding: EdgeInsets.all(6),
              ),
              endChild: const _RightChild(
                asset: 'assets/pedidos-icons/order_processed.png',
                title: 'Pedido en proceso',
                message: 'Estamos preparando tu pedido.',
              ),
              beforeLineStyle: const LineStyle(
                color: Color(0xFF27AA69),
              ),
              afterLineStyle: const LineStyle(
                color: Color(0xFFDADADA),
              ),
            ),
      
            TimelineTile(
              alignment: TimelineAlign.start,
              lineXY: 0.1,
              isLast: true,
              indicatorStyle: const IndicatorStyle(
                width: 20,
                color: Color(0xFFDADADA),
                padding: EdgeInsets.all(6),
              ),
              endChild: const _RightChild(
                disabled: true,
                asset: 'assets/pedidos-icons/ready_to_pickup.png',
                title: 'Pedido listo',
                message: 'Tu pedido esta listo.',
              ),
              beforeLineStyle: const LineStyle(
                color: Color(0xFFDADADA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EstimatedTimeBox extends StatelessWidget {
  const _EstimatedTimeBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: const Color(0xffD9D9D9),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("TIEMPO ESTIMADO", style: TextStyle(fontWeight: FontWeight.bold)),
              //TODO: El tiempo se debe llenar en base al objeto recibido de la base de datos
              Text("30 minutos")
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("NUMERO DE ORDEN", style: TextStyle(fontWeight: FontWeight.bold)),
              //TODO: El tiempo se debe llenar en base al objeto recibido de la base de datos
              Text("#25646541")
            ],
          ),

        ],
      ),
    );
  }
}

class _RightChild extends StatelessWidget {

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  const _RightChild({
    required this.asset, 
    required this.title, 
    required this.message, 
    this.disabled = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Opacity(
            opacity: disabled ? 0.5 : 1,
            child: Image.asset(asset, height: 50),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFBABABA)
                      : const Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFD5D5D5)
                      : const Color(0xFF636564),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
