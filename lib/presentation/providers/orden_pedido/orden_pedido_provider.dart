import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/presentation/providers/orden_pedido/orden_pedido_repository_provider.dart';

final ordenPedidoProvider = StateNotifierProvider<OrdenPedidoNotifier, List<OrdenPedido>>((ref){
  final createOrder = ref.watch( ordenPedidoRepositoryProvider ).createOrder;
  final fetchOrder = ref.watch( ordenPedidoRepositoryProvider ).getOrdersByCustomer;
  final fetchOrderByFilter = ref.watch( ordenPedidoRepositoryProvider ).getOrdersByFilter;

  return OrdenPedidoNotifier(
    createOrder: createOrder,
    fecthOrdersByCustomer: fetchOrder,
    fecthOrdersByCustomerAndFilter: fetchOrderByFilter,
  );
});

typedef OrdenPedidoCallBackByCustomer = Stream<List<OrdenPedido>> Function({required String idCliente});
typedef OrdenPedidoCallBackByCustomerAndFilter = Stream<List<OrdenPedido>> Function({required String idCliente, required String state});
typedef OrderPedidoCallBackCreate = Future<void> Function({required OrdenPedido order});

class OrdenPedidoNotifier extends StateNotifier<List<OrdenPedido>>{
  final OrderPedidoCallBackCreate createOrder;
  final OrdenPedidoCallBackByCustomer fecthOrdersByCustomer;
  final OrdenPedidoCallBackByCustomerAndFilter fecthOrdersByCustomerAndFilter;
  bool isLoading = false;

  OrdenPedidoNotifier({
    required this.createOrder,
    required this.fecthOrdersByCustomer,
    required this.fecthOrdersByCustomerAndFilter
  }):super([]);

  Future<void> createNewOrder(OrdenPedido order) async{
    if(isLoading) return;
    isLoading = true;

    await createOrder(order: order);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Stream<List<OrdenPedido>> getOrders(String idCliente) {    
    return fecthOrdersByCustomer(idCliente: idCliente);
  }

  Stream<List<OrdenPedido>> getOrdersByFilter(String idCliente, String orderState) {
    return fecthOrdersByCustomerAndFilter(idCliente: idCliente, state: orderState);
  }

  void setOrders(List<OrdenPedido> orders){
    state = orders;
  }


}