import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/presentation/helpers/format_dates.dart';
import 'package:la_carreta_express_cs/presentation/helpers/get_link_icon.dart';
import 'package:la_carreta_express_cs/presentation/providers/orden_pedido/orden_pedido_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/platos/initial_loading_provider.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class PedidosScreen extends ConsumerStatefulWidget {
  static const String name = 'pedidos_screen';
  const PedidosScreen({super.key});

  @override
  PedidosScreenState createState() => PedidosScreenState();
}


class PedidosScreenState extends ConsumerState<PedidosScreen> {

  @override
  void initState() {
    super.initState();
    ref.read( ordenPedidoProvider.notifier ).getOrders("DkkkqnIBV5OTH2s4eNJW"); //deleteCart -> set once time
  }

  @override
  void dispose() {
    print("Se destruye el listado de pedidos");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Reconstruccion del listado de pedidos");

    final size = MediaQuery.of(context).size;

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

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
            left: size.width * 0.37,//150
            child: const Text("Pedidos", style: TextStyle(fontSize: 30, color: Colors.white),)
          ),

          //Filter button
          Positioned(
            top: 50,
            right: 20,
            child: CustomFilterButton(onPressed: ()=>_showBottomSheet(context),)
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: _Pedidos(maximiunHeight: size.height * 0.80, maximiunWidth: size.width,)
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
    required this.maximiunHeight, required this.maximiunWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidoList = ref.watch( ordenPedidoProvider );
    print("Y la data???");

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
            child: ListView.builder(  
              physics: const BouncingScrollPhysics(),
              itemCount: pedidoList.length,
              itemBuilder: (context, index) {
                final urlIcon = getUrlIconPlatos();
                return _ItemPlato(maximiunWidth:maximiunWidth, urlIcon: urlIcon, pedido: pedidoList[index]);
              },
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
    return Container(
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
                Text("#${pedido.numOrden}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
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
          height: 460,
          color: Colors.grey[200],
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
                texto: "Pedido Realizado",
                value: 1,
                color: Color(0xff15616d),
              ),

              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey[300],
              ),

              const _OpcionFiltro(
                texto: "Pedido Confirmado",
                value: 2,
                color: Color(0xffff9f1c),
              ),

              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey[300],
              ),

              const _OpcionFiltro(
                texto: "Pedido En Proceso",
                value: 3,
                color: Color(0xff0ead69),
              ),

              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey[300],
              ),

              const _OpcionFiltro(
                texto: "Pedido En Cola",
                value: 4,
                color: Colors.grey,
              ),

              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey[300],
              ),

              const _OpcionFiltro(
                texto: "Pedido Listo",
                value: 5,
                color: Colors.pink,
              ),

              Divider(
                height: 0,
                thickness: 1,
                color: Colors.grey[300],
              ),

              const _OpcionFiltro(
                texto: "Pedido Cancelado",
                value: 6,
                color: Colors.brown,
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _OpcionFiltro extends StatelessWidget {
  final String texto;
  final int value;
  final Color color;
  const _OpcionFiltro({
    required this.texto,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        title: Text(texto),
        activeColor: color,
        value: value,
        groupValue: "optionSelected",
        onChanged: (value) {
          
      });
  }
}