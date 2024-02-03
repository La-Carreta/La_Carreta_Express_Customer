import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/carrito.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/presentation/providers/cart/cart_repository_provider.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Carrito>((ref){
  final fetchCarritoByIdCliente = ref.watch( cartRepositoryProvider ).getCarritoByIdCliente;
  final addOrUpdateItemCart = ref.watch( cartRepositoryProvider ).createOrUpdateDetallePedido;
  final emptyCart = ref.watch( cartRepositoryProvider ).deleteCart;
  final updateCart = ref.watch( cartRepositoryProvider ).updateDetallePedido;

  return CartNotifier(
    getCarritoByCliente: fetchCarritoByIdCliente, 
    addOrUpdateItem: addOrUpdateItemCart, 
    emptyCart: emptyCart, 
    updateCart: updateCart
  );
});

typedef CarritoCallBackByCustomer = Future<Carrito> Function({required String idCliente});
typedef CarritoCallBackById = Future<Carrito> Function({required String idCarrito});

typedef DetalleCallBack = Future<void> Function({String? idCarrito, required Cliente cliente, required DetallePedido detallePedido});
typedef EmptyCartCallBack = Future<void> Function({required String idCarrito, required Carrito cart});
typedef CartCallBack = Future<Carrito> Function({required Carrito carrito, required String idDetalle, required int cantidad});


class CartNotifier extends StateNotifier<Carrito>{
  final CarritoCallBackByCustomer getCarritoByCliente;
  final DetalleCallBack addOrUpdateItem;
  final CartCallBack updateCart;

  final EmptyCartCallBack emptyCart;
  bool isLoading = false;

  CartNotifier({
    required this.getCarritoByCliente,
    required this.addOrUpdateItem,
    required this.emptyCart,
    required this.updateCart,
  }):super(Carrito.empty());


  Future<void> loadCart(String idCliente) async{
    if(isLoading) return;
    isLoading = true;

    final Carrito carrito = await getCarritoByCliente(idCliente: idCliente);

    state = Carrito.copyWith(
      id: carrito.id,
      cliente: carrito.cliente,
      detallesPedido: carrito.detallesPedido,
      total: carrito.total
    );

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> addOrUpdateItemCart({String? idCarrito, required Cliente cliente, required DetallePedido item}) async{
    if(isLoading) return;
    isLoading = true;
    //Buscar si el pedido se encuentra en la lista
    await addOrUpdateItem(cliente: cliente, detallePedido: item);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> deleteCart(String idCarrito, Carrito cart) async{
    if(isLoading) return;
    isLoading = true;

    await emptyCart(idCarrito: idCarrito, cart: cart);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> updateDetallePedidoCart({required String idDetalle, required Carrito carrito, required int cantidad}) async {
    // Inicia el cronómetro
    Stopwatch stopwatch = Stopwatch()..start();
    if(isLoading) return;
    isLoading = true;

    final cartUpdated = await updateCart(cantidad: cantidad, carrito: carrito, idDetalle: idDetalle);

    state = Carrito.copyWith(
      id: cartUpdated.id,
      cliente: cartUpdated.cliente,
      detallesPedido: cartUpdated.detallesPedido,
      total: cartUpdated.total
    );

    await Future.delayed(const Duration(milliseconds: 100));
    isLoading = false;

    // Detiene el cronómetro
    stopwatch.stop();

    // Obtiene el tiempo transcurrido en milisegundos
    int tiempoTranscurrido = stopwatch.elapsedMilliseconds;

    print('El proceso tardó $tiempoTranscurrido milisegundos en ejecutarse.');
  }
}

