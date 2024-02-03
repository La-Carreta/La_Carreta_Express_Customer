import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/presentation/providers/orden_pedido/orden_pedido_repository_provider.dart';

final ordenPedidoInfoProvider = StateNotifierProvider<OrdenPedidoInfoNotifier, Map<String, OrdenPedido>>((ref){
  final fetchOrderById = ref.watch( ordenPedidoRepositoryProvider ).getOrderById;

  return OrdenPedidoInfoNotifier(
    fetchtOrderById: fetchOrderById
  );
});

typedef OrdenPedidoCallBackById = Future<OrdenPedido> Function({required String idOrdenPedido});

class OrdenPedidoInfoNotifier extends StateNotifier<Map<String, OrdenPedido>>{

  final OrdenPedidoCallBackById fetchtOrderById;
  OrdenPedidoInfoNotifier({required this.fetchtOrderById}):super({});
  
  Future<void> getOrderById(String idOrden) async{
    if( state[idOrden] != null) return;
 
    final orden = await fetchtOrderById(idOrdenPedido: idOrden);
    state = {...state, idOrden: orden};

    await Future.delayed(const Duration(milliseconds: 300));
  }
}