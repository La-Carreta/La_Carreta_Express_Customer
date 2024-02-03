import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';

abstract class OrdenPedidoDatasource{
  Future<List<OrdenPedido>> getOrdersByCustomer({required String idCliente});  
  Future<void> createOrder({required OrdenPedido order});  
  Future<void> cancelOrder({required OrdenPedido order});  
  Future<OrdenPedido> getOrderById({required String idOrdenPedido});  
}
