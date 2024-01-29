import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/presentation/providers/orden_pedido/orden_pedido_repository_provider.dart';

final ordenPedidoProvider = StateNotifierProvider<OrdenPedidoNotifier, List<OrdenPedido>>((ref){
  final createOrder = ref.watch( ordenPedidoRepositoryProvider ).createOrder;

  return OrdenPedidoNotifier(
    createOrder: createOrder
  );
});

typedef OrdenPedidoCallBackByCustomer = Future<List<OrdenPedido>> Function({required String idCliente});
typedef OrdenPedidoCallBackById = Future<OrdenPedido> Function({required String idOrden});
typedef OrderPedidoCallBackCreate = Future<void> Function({required OrdenPedido order});

class OrdenPedidoNotifier extends StateNotifier<List<OrdenPedido>>{
  final OrderPedidoCallBackCreate createOrder;
  bool isLoading = false;

  OrdenPedidoNotifier({
    required this.createOrder
  }):super([]);

  Future<void> createNewOrder(OrdenPedido order) async{
    if(isLoading) return;
    isLoading = true;
    //Buscar si el pedido se encuentra en la lista
    await createOrder(order: order);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

}