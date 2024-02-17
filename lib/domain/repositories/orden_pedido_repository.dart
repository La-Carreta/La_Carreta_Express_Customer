import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';

abstract class OrdenPedidoRepository{
  Stream<List<OrdenPedido>> getOrdersByCustomer({required String idCliente});  
  Future<void> createOrder({required OrdenPedido order});  
  Stream<OrdenPedido> getOrderById({required String idOrdenPedido});  
  Stream<List<OrdenPedido>> getOrdersByFilter({required String idCliente, required String state});
}
