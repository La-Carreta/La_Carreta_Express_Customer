import 'package:la_carreta_express_cs/domain/entities/detalle_orden_pedido.dart';

abstract class DetalleOrdenPedidoDataSource{
  Future<List<DetalleOrdenPedido>> getDetallesCarrito();//Server
  Future<DetalleOrdenPedido> updateDetalleCarritoById(int id, int cantidad);  
  Future<void> deleteDetalleCarrito();  
  Future<void> createDetalleCarrito();      
}