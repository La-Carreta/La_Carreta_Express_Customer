import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_orden_pedido.dart';
import 'package:la_carreta_express_cs/presentation/providers/detalle_orden_pedido_provider.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const String name = 'cart_screen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
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
            left: size.width * 0.40,//150
            child: const Text("Carrito", style: TextStyle(fontSize: 30, color: Colors.white),)
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: _DetallePedido(maximiunHeight: size.height * 0.80, maximiunWidth: size.width,)
          ),
        ],
      ),
    );
  }
}

class _DetallePedido extends StatelessWidget {
  final double maximiunHeight;
  final double maximiunWidth;

  const _DetallePedido({
    required this.maximiunHeight, required this.maximiunWidth,
  });

  @override
  Widget build(BuildContext context) {

    final detalleOrdenProvider = context.watch<DetalleOrdenPedidoProvider>();
    final data = detalleOrdenProvider.detallesPedido;

    return Container(
      width: maximiunWidth,
      height: maximiunHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(25)),
      ),
      child: data.isNotEmpty
        ? _DetallePedidoView(maximiunWidth: maximiunWidth, listaDetalleOrden: data)
        : const _NoData(),
    );
  }
}

class _NoData extends StatelessWidget {
  const _NoData();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Sin Platos")
      ],
    );
  }
}

class _DetallePedidoView extends StatelessWidget {
  const _DetallePedidoView({
    required this.maximiunWidth, 
    required this.listaDetalleOrden,
  });

  final double maximiunWidth;
  final List<DetalleOrdenPedido> listaDetalleOrden;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [          
        //Title and cost
        const Text("Detalle del Pedido", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),),
    
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: listaDetalleOrden.length,
            itemBuilder: (context, index) {
              return _ItemCartPlato(maximiunWidth:maximiunWidth, detalleOrden: listaDetalleOrden[index]);
            },
          )
        ),
    
        const SizedBox(height: 15),
        const Text("Observaciones", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
        
        TextFormField(
          minLines: 3,
          maxLines: 6,
          keyboardType: TextInputType.multiline,
        ),
    
        const SizedBox(height: 10),
    
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("\$40.70", style: TextStyle(fontSize: 18,  fontWeight: FontWeight.bold))
          ],
        ),
    
        FilledButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(170, 40)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
          ),
          onPressed: (){}, 
          child: const Text("Realizar Pedido", style: TextStyle(fontWeight: FontWeight.bold),),                
        ),
      ],
    );
  }
}

class _ItemCartPlato extends StatelessWidget {
  final double maximiunWidth;
  final DetalleOrdenPedido detalleOrden;
  const _ItemCartPlato({
    required this.maximiunWidth, required this.detalleOrden,
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
            borderRadius: BorderRadius.circular(25),
            child: Image.network(detalleOrden.imgUrl, width: 80, fit: BoxFit.cover,)
          ), 
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(detalleOrden.nombre, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                Text(detalleOrden.descripcion),
                const SizedBox(height: 15),          
              ],
            ),
          ),

          SizedBox(
            width: maximiunWidth * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.remove), 
                      color: Colors.white,
                      style: ButtonStyle(                        
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(126, 88, 47, 14))
                      ),
                    ),
                    Text("${detalleOrden.cantidad}"),
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.add), 
                      color: Colors.white,
                      style: ButtonStyle(                        
                        backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
                      ),
                    ),
                  ],
                ),
                Text("\$${detalleOrden.precio}", style: const TextStyle(fontSize: 17),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
