import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/presentation/helpers/custom_snackbar.dart';
import 'package:la_carreta_express_cs/presentation/helpers/format_dates.dart';
import 'package:la_carreta_express_cs/presentation/providers/customer/customer_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/orden_pedido/orden_pedido_filter.dart';
import 'package:la_carreta_express_cs/presentation/providers/orden_pedido/orden_pedido_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/platos/filter_plato_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/platos/initial_loading_provider.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class PedidosScreen extends ConsumerWidget {
  static const String name = 'pedidos_screen';
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    return Scaffold(
      body: Stack(
        children: [
          //Background
          const ImageBackground(imgUrl: "assets/background/main.png"),

          //Back button
          Positioned(
            top: 50,
            left: 20,
            child: FadeInLeft(
              from: 50,
              child: const CustomBackButton(),
            ),
          ),

          //Title
          Positioned(
            top: 55,
            left: size.width * 0.37,//150
            child: FadeInLeft(
              from: 50,
              child: const Text("Pedidos", style: TextStyle(fontSize: 30, color: Colors.white),)
            )
          ),

          //Filter button
          Positioned(
            top: 50,
            right: 20,
            child: FadeInLeft(
              from: 50,
              child: CustomFilterButton(
                onPressed: ()=> _showBottomSheet(context),
              ),
            )
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: _Pedidos(
              maximiunHeight: size.height * 0.80, 
              maximiunWidth: size.width,
            )
          ),
        ],
      ),
    );
  }
}


class _Pedidos extends ConsumerWidget {
  final double maximiunHeight;
  final double maximiunWidth;

  const _Pedidos({
    required this.maximiunHeight, 
    required this.maximiunWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterOptionSelected = ref.watch(filterOptionPedidoProvider);
    final customer = ref.watch(customerProvider);
    Stream<List<OrdenPedido>> getOrdersByFilterState(){
      if(filterOptionSelected == "Todos"){
        return ref.read( ordenPedidoProvider.notifier ).getOrders(customer.id);
      }else{
        return ref.read( ordenPedidoProvider.notifier ).getOrdersByFilter(customer.id, filterOptionSelected);
      }    
    }

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
          Expanded(
            child: StreamBuilder<List<OrdenPedido>>(              
              stream: getOrdersByFilterState(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }
                
                if(snapshot.hasError){
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if(snapshot.data!.isEmpty){
                  return NoDataFound(maximiunWidth: maximiunWidth, maximiunHeight: maximiunHeight * 0.9, pathLottie: "assets/lottie/json/no-orders.json", text: "No hay pedidos");
                }

                final pedidoList = snapshot.data!;

                return ListView.builder(  
                  physics: const BouncingScrollPhysics(),
                  itemCount: pedidoList.length,
                  itemBuilder: (context, index) {
                    const urlIcon = "https://res.cloudinary.com/dwexseytn/image/upload/v1708610624/La_Carreta_Express/Various_icons/entrega-de-comida_vnwcbn.png";
                    return pedidoList[index].estadoOrden == "Pedido realizado"
                      ?                                        
                      Slidable(
                        key: UniqueKey(),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(), 
                          children: [
                            if(pedidoList[index].estadoOrden == "Pedido realizado")
                              SlidableAction(
                                onPressed: (context){
                                  ref.watch( ordenPedidoProvider.notifier ).cancelOrderById(pedidoList[index].id);
                                  //Mostrar un snackbar
                                  showCustomSnackbar(context: context, title: "Orden #${pedidoList[index].numOrden} cancelada satisfactoriamente.");
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.brown,
                                foregroundColor: Colors.white,
                                label: "Cancelar Orden",
                              ),
                          ]
                        ),
                        child: FadeInUp(child: _ItemPlato(maximiunWidth:maximiunWidth, urlIcon: urlIcon, pedido: pedidoList[index]))
                      )
                    : FadeInUp(child: _ItemPlato(maximiunWidth:maximiunWidth, urlIcon: urlIcon, pedido: pedidoList[index]));
                  },
                );
              }
            )
          ),
        ],
      ),
    );
  }
}

class _ItemPlato extends StatelessWidget {
  final double maximiunWidth;
  final String urlIcon;
  final OrdenPedido pedido;

  const _ItemPlato({
    required this.maximiunWidth, required this.urlIcon, required this.pedido,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 120,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xffe9ecef))
          ),
          child: Row(
            children: [
              //Img del plato
              Image.network(urlIcon, width: 80, fit: BoxFit.cover,), 
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order: #${pedido.numOrden}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                    Text("Mesa-${pedido.numMesa}"),
                    Text( formatDate(pedido.fechaEmision) ),//15-Nov-2023 17h15
                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IndicadorEstado(state: pedido.estadoOrden),
                        const SizedBox(width: 10),
                        Text(pedido.estadoOrden, maxLines: 2, overflow: TextOverflow.ellipsis,)
                      ],
                    )
                  ],
                ),
              ),
        
              SizedBox(
                width: maximiunWidth * 0.15,
                child: Center(
                  child: IconButton(
                    onPressed: () => context.push("/seguimiento-pedido/${pedido.id}"), 
                    icon: const Icon(Icons.chevron_right)
                  ),
                ),
              )
            ],
          ),
        ),

        if(pedido.statusPago)
          const _BadgePayment(),
      ],
    );
  }
}

class _BadgePayment extends StatelessWidget {
  const _BadgePayment();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 5,
      top: 0,
      child: Container(
        width: 50,
        height: 30,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)
          ),
        ),
        child: const Center(
          child: Text("Pagado", style: TextStyle(color: Colors.white, fontSize: 10),),
        )
      ),
    );
  }
}

void _showBottomSheet(context) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (BuildContext context) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: Container(
          height: 490,
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Filtrar pedidos por estado",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
            
                //Opciones con Radio
                const SizedBox(height: 10),
            
                const _OpcionFiltro(
                  texto: "Todos",
                  value: 0,
                  color: Colors.indigo,
                ),
            
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
            
                const _OpcionFiltro(
                  texto: "Pedido realizado",
                  value: 1,
                  color: Color(0xff15616d),
                ),
            
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
            
                const _OpcionFiltro(
                  texto: "Pedido confirmado",
                  value: 2,
                  color: Color(0xffff9f1c),
                ),
            
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
            
                const _OpcionFiltro(
                  texto: "Pedido en preparación",
                  value: 3,
                  color: Color(0xff0ead69),
                ),
            
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
            
                const _OpcionFiltro(
                  texto: "Pedido en cola",
                  value: 4,
                  color: Colors.grey,
                ),
            
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
            
                const _OpcionFiltro(
                  texto: "Pedido listo",
                  value: 5,
                  color: Colors.pink,
                ),
            
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
            
                const _OpcionFiltro(
                  texto: "Pedido entregado",
                  value: 6,
                  color: Colors.pink,
                ),
            
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
            
                const _OpcionFiltro(
                  texto: "Pedido cancelado",
                  value: 7,
                  color: Colors.brown,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _OpcionFiltro extends ConsumerWidget {
  final String texto;
  final int value;
  final Color color;

  const _OpcionFiltro({
    required this.texto,
    required this.value,
    required this.color, 
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final optionFilterSelected = ref.watch( filterOptionPlates ); 
    final customerData = ref.read(customerProvider);
    return RadioListTile(
      title: Text(texto),
      activeColor: color,
      value: value,
      tileColor: color,
      selectedTileColor: color,
      groupValue: optionFilterSelected,
      onChanged: (newValue) {
        ref.read(filterOptionPlates.notifier).state = newValue as int;
        if(texto == "Todos"){
          ref.read( ordenPedidoProvider.notifier ).getOrders(customerData.id);
          ref.read( filterOptionPedidoProvider.notifier).state = "Todos";
        }else{
          ref.read( ordenPedidoProvider.notifier ).getOrdersByFilter(customerData.id, texto);
          ref.read( filterOptionPedidoProvider.notifier).state = texto;
        }
    });
  }
}