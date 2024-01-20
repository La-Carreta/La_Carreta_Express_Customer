import 'package:la_carreta_express_cs/domain/datasource/carrito_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/carrito.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/domain/repositories/carrito_repository.dart';

class CarritoRepositoryImpl extends CarritoRepository{
  final CarritoDatasource datasource;

  CarritoRepositoryImpl(this.datasource);
 
  @override
  Future<void> deleteDetallePedido({required String idCarrito, required String idDetalle}) {
    return datasource.deleteDetallePedido(idCarrito: idCarrito, idDetalle: idDetalle);
  }

  @override
  Future<Carrito> getCarrito({required Cliente cliente}) {
    return datasource.getCarrito(cliente: cliente);
  }

  @override
  Future<void> updateDetallePedido({required String idCarrito, required String idDetalle, required int cantidad}) {
    return updateDetallePedido(idCarrito: idCarrito, idDetalle: idDetalle, cantidad: cantidad);
  }
  
  @override
  Future<void> createDetallePedido({String? idCarrito, required Cliente cliente, required DetallePedido detallePedido}) {
    return datasource.createDetallePedido(idCarrito: idCarrito, cliente: cliente, detallePedido: detallePedido);
  }
  
  @override
  Future<void> deleteCart({required String idCarrito}) {
    return datasource.deleteCart(idCarrito: idCarrito);
  }
}