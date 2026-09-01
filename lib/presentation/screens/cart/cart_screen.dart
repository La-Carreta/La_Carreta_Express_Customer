import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/domain/entities/entities.dart';
import 'package:la_carreta_express_cs/presentation/presentation.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});
  static const String name = 'cart_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerProvider);

    ref.watch(timeOrderProvider.notifier).getEstimatedTime();
    ref.watch(cartProvider.notifier).loadCart(customer.id);

    final initialLoading = ref.watch(cartInitialLoadingProvider);
    if (initialLoading) return const Scaffold(body: FullScreenLoader());

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          //Background
          const ImageBackground(imgUrl: "assets/background/main.png"),

          //Back button
          const Positioned(top: 50, left: 20, child: CustomBackButton()),

          //Title
          Positioned(
              top: 55,
              left: size.width * 0.40, //150
              child: const Text(
                "Carrito",
                style: TextStyle(fontSize: 30, color: Colors.white),
              )),

          Positioned(
              bottom: 0,
              left: 0,
              child: _DetallePedido(
                maximiunHeight: size.height * 0.80,
                maximiunWidth: size.width,
              )),
        ],
      ),
    );
  }
}

class _DetallePedido extends ConsumerWidget {
  final double maximiunHeight;
  final double maximiunWidth;

  const _DetallePedido({
    required this.maximiunHeight,
    required this.maximiunWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Carrito carrito = ref.watch(cartProvider);
    final TextEditingController observacionesController =
        TextEditingController();
    final numMesa = ref.watch(numMesaProvider);

    if (carrito.detallesPedido.isEmpty) {
      return NoDataFound(
          maximiunWidth: maximiunWidth,
          maximiunHeight: maximiunHeight,
          pathLottie: 'assets/lottie/json/empty_cart.json',
          text: "El carrito esta vacio...");
    }

    final estimatedTime = ref.watch(timeOrderProvider);

    void showConfirmDialog(OrdenPedido ordenPedido) async {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text("Confirmar Pedido"),
            content: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("NOTA: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Tiempo de espera:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ordenPedido.tiempoEstimado,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                      )
                    ]),
                  ),
                  const SizedBox(height: 10),
                  const Text("¿Desea continuar con el pedido?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            actions: [
              FilledButton(
                style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(100, 40)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                    backgroundColor:
                        WidgetStateProperty.all(const Color(0xffe63946))),
                onPressed: () {
                  context.pop();
                },
                child: const Text(
                  "Cancelar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              FilledButton(
                style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(120, 40)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                    backgroundColor:
                        WidgetStateProperty.all(const Color(0xff023047))),
                onPressed: () async {
                  await ref
                      .read(ordenPedidoProvider.notifier)
                      .createNewOrder(ordenPedido);
                  await ref
                      .read(cartProvider.notifier)
                      .deleteCart(carrito.id, carrito);
                  if (!context.mounted) return;
                  context.go('/order-success');
                },
                child: const Text(
                  "Si, continuar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
    }

    return Container(
      width: maximiunWidth,
      height: maximiunHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Title and cost
          const Text(
            "Detalle del Pedido",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
          ),

          Expanded(
              child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: carrito.detallesPedido.length,
            itemBuilder: (context, index) {
              final item = carrito.detallesPedido[index];
              return Slidable(
                  key: UniqueKey(),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => ref
                            .watch(cartProvider.notifier)
                            .deleteDetallePedidoCart(
                                idCarrito: carrito.id,
                                idDetalle: item.id,
                                cart: carrito),
                        icon: Icons.delete,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        label: "Eliminar",
                      )
                    ],
                  ),
                  child: _ItemCartPlato(
                      maximiunWidth: maximiunWidth, item: item, cart: carrito));
            },
          )),

          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Num. de mesa: ",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              SizedBox(
                width: 60,
                child: DropdownButtonFormField(
                  initialValue: numMesa,
                  items: List.generate(
                      15,
                      (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text("${index + 1}"),
                          )),
                  onChanged: (value) =>
                      ref.watch(numMesaProvider.notifier).state = value ?? 1,
                ),
              )
            ],
          ),

          const SizedBox(height: 15),
          const Text(
            "Observaciones",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),

          TextFormField(
            controller: observacionesController,
            minLines: 3,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("\$${carrito.total.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))
            ],
          ),

          FilledButton(
            style: ButtonStyle(
                minimumSize: WidgetStateProperty.all(const Size(170, 40)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xff582F0E))),
            onPressed: () {
              final observaciones = observacionesController.text;
              final tiempoEstimado = calculateEstimatedTime(estimatedTime);

              final ordenPedido = OrdenPedido(
                  cliente: carrito.cliente,
                  fechaEmision: DateTime.now(),
                  mesero: Mesero.empty(),
                  costoTotalPedido: carrito.total,
                  numOrden: generateOrderNumber(),
                  observaciones: observaciones,
                  numMesa: numMesa,
                  detalles: carrito.detallesPedido,
                  tiempoEstimado: tiempoEstimado);

              showConfirmDialog(ordenPedido);
            },
            child: const Text(
              "Realizar Pedido",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemCartPlato extends ConsumerWidget {
  final DetallePedido item;
  final Carrito cart;
  final double maximiunWidth;

  const _ItemCartPlato(
      {required this.maximiunWidth, required this.item, required this.cart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffe9ecef))),
      child: Row(
        children: [
          //Img del plato
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                item.plato.platoUrl,
                width: 80,
                fit: BoxFit.cover,
              )),
          const SizedBox(width: 10),

          SizedBox(
              width: maximiunWidth * 0.35,
              child: Text(
                item.plato.nombre,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              )),

          SizedBox(
            width: maximiunWidth * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        final int cantidad = item.cantidadPlato - 1;
                        if (cantidad > 0) {
                          ref
                              .watch(cartProvider.notifier)
                              .updateDetallePedidoCart(
                                  cantidad: cantidad,
                                  carrito: cart,
                                  idDetalle: item.id);
                        }
                      },
                      icon: const Icon(Icons.remove),
                      color: Colors.white,
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(126, 88, 47, 14))),
                    ),
                    Text(
                      "${item.cantidadPlato}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      onPressed: () {
                        final int cantidad = item.cantidadPlato + 1;
                        ref
                            .watch(cartProvider.notifier)
                            .updateDetallePedidoCart(
                                cantidad: cantidad,
                                carrito: cart,
                                idDetalle: item.id);
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(const Color(0xff582F0E))),
                    ),
                  ],
                ),
                Text(
                  '\$${item.valorTotal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
