import 'package:la_carreta_express_cs/domain/entities/detalle_orden_pedido.dart';

abstract class DetalleOrdenPedidoRepository{
  Future<List<DetalleOrdenPedido>> getDetallesCarrito();  
  Future<DetalleOrdenPedido> updateDetalleCarritoById(int id, int cantidad);  
  Future<void> deleteDetalleCarrito();  
  Future<void> createDetalleCarrito();      
}