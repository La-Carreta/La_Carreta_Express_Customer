import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/infraestructure/models/time_line_data.dart';
import 'package:la_carreta_express_cs/presentation/helpers/order_time_line.dart';
import 'package:la_carreta_express_cs/presentation/providers/providers.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class SeguimientoPedidoScreen extends ConsumerWidget {
  static const String name = 'seguimiento_pedido_screen';

  const SeguimientoPedidoScreen({super.key, required this.idPedido});
  final String idPedido;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;  
    return Scaffold(
      body: Stack(
        children: [
          const ImageBackground(imgUrl: "assets/background/main.png"),

          //Back button
          Positioned(
            top: 50,
            left: 20,
            child: FadeInLeft(
              from: 50,
              child: const CustomBackButton()
            )
          ),

          
          //Title
          Positioned(
            top: 55,
            left: size.width * 0.25,//150
            child: FadeInDown(
              from: 50,
              child: const Text("Seguimiento del Pedido", style: TextStyle(fontSize: 27, color: Colors.white),)
            )
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: StreamBuilder<OrdenPedido>(
              stream: ref.watch(ordenPedidoInfoProvider.notifier).getOrderById(idPedido),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) return const CircularProgressIndicator();
                if(!snapshot.hasData) return const Text("No se encontró el pedido");
                final pedido = snapshot.data!;

                return _SiguimientoPedidoView(
                  maximiunHeight: size.height * 0.85, 
                  maximiunWidth: size.width,
                  pedido: pedido
                );
              }
            )
          ),
        ],
      ),
    );
  }
}

class _SiguimientoPedidoView extends ConsumerWidget {
  final double maximiunHeight;
  final double maximiunWidth;
  final OrdenPedido pedido;
  
  const _SiguimientoPedidoView({
    required this.maximiunHeight, 
    required this.maximiunWidth, 
    required this.pedido
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentState = OrderTimelineData.getTimelineData(statusOrder: pedido.estadoOrden, idOrder: pedido.id);
    
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
          FadeInRight(child: _EstimatedTimeBox(estimatedTime: pedido.tiempoEstimado, numOrder: pedido.numOrden)),

          const SizedBox(height: 10),

          //Linea de tiempo
          FadeInLeft(child: _TimeLinePedido(currentState)),

          const SizedBox(height: 10),

          //Boton de detalles de pedido
          FilledButton(
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all(const Size(300, 40)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
              backgroundColor: WidgetStateProperty.all(const Color(0xFFe9ecef))
            ),
            onPressed: ()=> context.push("/detalle-pedido/${pedido.id}"), 
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
  const _TimeLinePedido(this.timelineData);

  final TimelineData timelineData;

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
              indicatorStyle: IndicatorStyle(
                width: 20,
                color: timelineData.colors[0].indicatorColor, 
                padding: const EdgeInsets.all(6),
              ),
              endChild: _TimelineOption(
                asset: 'assets/pedidos-icons/order_placed.png',
                title: 'Pedido realizado',
                message: 'Hemos recibido su pedido.',
                index: 1,
                disabled: !timelineData.colors[0].statePassed,
              ),
              beforeLineStyle: LineStyle(
                color: timelineData.colors[0].beforeLineColor,
              ),
            ), 
      
            TimelineTile(
              alignment: TimelineAlign.start,
              lineXY: 0.1,
              indicatorStyle: IndicatorStyle(
                width: 20,
                color: timelineData.colors[1].indicatorColor,
                padding: const EdgeInsets.all(6),
              ),
              endChild: _TimelineOption(
                asset: 'assets/pedidos-icons/order_confirmed.png',
                title: 'Pedido confirmado',
                message: 'Tu pedido ha sido confirmado.',
                index: 2,
                disabled: !timelineData.colors[1].statePassed,
              ),
              beforeLineStyle: LineStyle(
                color: timelineData.colors[1].beforeLineColor,
              ),//0xFFDADADA
            ),        
      
            TimelineTile(
              alignment: TimelineAlign.start,
              lineXY: 0.1,
              indicatorStyle: IndicatorStyle(
                width: 20,
                color: timelineData.colors[2].indicatorColor,
                padding: const EdgeInsets.all(6),
              ),
              endChild: _TimelineOption(
                asset: 'assets/pedidos-icons/order_processed.png',
                title: 'Pedido en preparación',
                message: 'Estamos preparando tu pedido.',
                index: 3,
                disabled: !timelineData.colors[2].statePassed,
              ),
              beforeLineStyle: LineStyle(
                color: timelineData.colors[2].beforeLineColor,
              ),
              afterLineStyle: LineStyle(
                color: timelineData.colors[2].afterLineColor,
              //  color: Color(0xFFDADADA),
              ),
            ),
      
            TimelineTile(
              alignment: TimelineAlign.start,
              lineXY: 0.1,
              isLast: true,
              indicatorStyle: IndicatorStyle(
                width: 20,
                color: timelineData.colors[3].indicatorColor,
                padding: const EdgeInsets.all(6),
              ),
              endChild: _TimelineOption(
                disabled: !timelineData.colors[3].statePassed,                
                asset: 'assets/pedidos-icons/ready_to_pickup.png',
                title: 'Pedido listo',
                message: 'Tu pedido esta listo.',
                index: 4,                                
              ),
              beforeLineStyle: LineStyle(
                color: timelineData.colors[3].beforeLineColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EstimatedTimeBox extends StatelessWidget {
  final String estimatedTime;
  final String numOrder;

  const _EstimatedTimeBox({
    required this.estimatedTime,
    required this.numOrder
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: const Color(0xffD9D9D9),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("TIEMPO ESTIMADO", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(estimatedTime.isEmpty ? "10 min" : estimatedTime)
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("NUMERO DE ORDEN", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("#$numOrder")
            ],
          ),

        ],
      ),
    );
  }
}

class _TimelineOption extends StatelessWidget {

  final String asset;
  final String title;
  final String message;
  final bool disabled;
  final int index;

  const _TimelineOption({
    required this.asset, 
    required this.title, 
    required this.message, 
    this.disabled = false, 
    required this.index
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
