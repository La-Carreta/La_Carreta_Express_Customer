import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/presentation/providers/orden_pedido/orden_pedido_repository_provider.dart';

final ordenPedidoProvider = StateNotifierProvider<OrdenPedidoNotifier, List<OrdenPedido>>((ref){
  final createOrder = ref.watch( ordenPedidoRepositoryProvider ).createOrder;
  final fetchOrder = ref.watch( ordenPedidoRepositoryProvider ).getOrdersByCustomer;
  final fetchOrderById = ref.watch( ordenPedidoRepositoryProvider ).getOrderById;

  return OrdenPedidoNotifier(
    createOrder: createOrder,
    fecthOrdersByCustomer: fetchOrder,
    fetchtOrderById: fetchOrderById
  );
});

typedef OrdenPedidoCallBackByCustomer = Future<List<OrdenPedido>> Function({required String idCliente});
typedef OrdenPedidoCallBackById = Future<OrdenPedido> Function({required String idOrdenPedido});
typedef OrderPedidoCallBackCreate = Future<void> Function({required OrdenPedido order});


class OrdenPedidoNotifier extends StateNotifier<List<OrdenPedido>>{
  final OrderPedidoCallBackCreate createOrder;
  final OrdenPedidoCallBackByCustomer fecthOrdersByCustomer;
  final OrdenPedidoCallBackById fetchtOrderById;
  bool isLoading = false;

  OrdenPedidoNotifier({
    required this.createOrder,
    required this.fecthOrdersByCustomer,
    required this.fetchtOrderById
  }):super([]);

  Future<void> createNewOrder(OrdenPedido order) async{
    if(isLoading) return;
    isLoading = true;
    //Buscar si el pedido se encuentra en la lista
    await createOrder(order: order);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> getOrders(String idCliente) async{
    if(isLoading) return;
    isLoading = true;
    //Buscar si el pedido se encuentra en la lista
    state = await fecthOrdersByCustomer(idCliente: idCliente);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> getOrderById(String idOrden) async{
    if(isLoading) return;
    isLoading = true;
    //Buscar si el pedido se encuentra en la lista
    state = [await fetchtOrderById(idOrdenPedido: idOrden)];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

}