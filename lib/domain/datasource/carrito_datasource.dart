import 'package:la_carreta_express_cs/domain/entities/carrito.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';

abstract class CarritoDatasource{
  Future<Carrito> getCarritoByIdCliente({required String idCliente});
  Future<Carrito> getCarritoById({required String idCarrito});
  Future<Carrito> updateDetallePedido({required Carrito carrito, required String idDetalle, required int cantidad});
  Future<void> deleteDetallePedido({required String idCarrito, required String idDetalle});
  Future<void> createOrUpdateDetallePedido({String? idCarrito, required Cliente cliente, required DetallePedido detallePedido});  
  Future<void> deleteCart({required String idCarrito});

}
