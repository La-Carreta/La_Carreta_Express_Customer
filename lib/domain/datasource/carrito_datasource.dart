import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';

abstract class CarritoDatasource{
  Future<List<DetallePedido>> getCarrito();
  Future<void> updateDetallePedido(String idDetalle, int cantidad);
  Future<void> deleteDetallePedido(String idDetalle);
}
