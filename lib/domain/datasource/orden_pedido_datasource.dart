import 'package:la_carreta_express_cs/domain/entities/estimated_time.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';

abstract class OrdenPedidoDatasource{
  Stream<List<OrdenPedido>> getOrdersByCustomer({required String idCliente});  
  Future<void> createOrder({required OrdenPedido order});  
  Stream<OrdenPedido> getOrderById({required String idOrdenPedido});  
  Stream<List<OrdenPedido>> getOrdersByFilter({required String idCliente, required String state});
  Future<void> cancelOrder({required String idOrdenPedido});
  Future<void> deleteOrder({required String idOrdenPedido});
  Future<EstimatedTime> getEstimatedTime();
}
