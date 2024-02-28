import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/entities.dart';
import 'package:la_carreta_express_cs/presentation/helpers/format_dates.dart';
import 'package:la_carreta_express_cs/presentation/providers/orden_pedido/orden_pedido_info_provider.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class DetallePedidoScreen extends ConsumerWidget {
  static const String name = 'detalle_pedido_screen';

  const DetallePedidoScreen({super.key, required this.idPedido});
  final String idPedido;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children:[
          //Background
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
            child: const Text("Detalle del Pedido", style: TextStyle(fontSize: 30, color: Colors.white),)
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: StreamBuilder<OrdenPedido>(
              stream: ref.watch(ordenPedidoInfoProvider.notifier).getOrderById(idPedido),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }

                if(!snapshot.hasData){
                  return const Center(child: Text("No se encontró el pedido"));
                }

                final pedido = snapshot.data;                      

                return _DetallePedido(maximiunHeight: size.height * 0.80, maximiunWidth: size.width, ordenPedido: pedido!);
              }
            )
          ),
        ]
      ),
    );
  }
}

class _DetallePedido extends StatelessWidget {
  final double maximiunHeight;
  final double maximiunWidth;
  final OrdenPedido ordenPedido;

  const _DetallePedido({
    required this.maximiunHeight, required this.maximiunWidth, required this.ordenPedido,
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
          //Title and cost
          FadeInLeft(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("# de orden", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                Text("#${ordenPedido.numOrden}", style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),

          FadeInLeft(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Fecha", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                Text(formatDate(ordenPedido.fechaEmision), style: const TextStyle(fontSize: 20, color: Color(0xff9D9D9D))),
              ],
            ),
          ),

          FadeInRight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(ordenPedido.estadoOrden),
                const SizedBox(width: 10),
                IndicadorEstado(state: ordenPedido.estadoOrden),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: ordenPedido.detalles.length,
              itemBuilder: (context, index) {
                final item = ordenPedido.detalles[index];
                return FadeInDown(
                  from: 30,
                  child: _ItemCartPlato(maximiunWidth:maximiunWidth, item: item)
                );
              },
            )
          ),

          const SizedBox(height: 15),
          const Text("Observaciones", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
          
          TextFormField(
            minLines: 3,
            maxLines: 6,
            readOnly: true,
            keyboardType: TextInputType.multiline,
            initialValue: ordenPedido.observaciones,
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("\$${ordenPedido.costoTotalPedido.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18,  fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemCartPlato extends StatelessWidget {
  final double maximiunWidth;
  final DetallePedido item;
  
  const _ItemCartPlato({
    required this.maximiunWidth, 
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffe9ecef))
      ),
      child: Row(
        children: [
          //Img del plato
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(item.plato.platoUrl, width: 80, fit: BoxFit.cover,)
          ), 
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.plato.nombre, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),maxLines: 2),
                const SizedBox(height: 15),          
              ],
            ),
          ),

          SizedBox(
            width: maximiunWidth * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 15),
                Text("${item.cantidadPlato}", style: const TextStyle(fontSize: 17),),
                Text('\$${item.valorTotal.toStringAsFixed(2)}', style: const TextStyle(fontSize: 17),),
                const SizedBox(height: 15),
              ],
            ),
          )
        ],
      ),
    );
  }
}


