import 'package:la_carreta_express_cs/domain/datasource/carrito_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/carrito.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/domain/repositories/carrito_repository.dart';

class CarritoRepositoryImpl extends CarritoRepository{
  final CarritoDatasource datasource;

  CarritoRepositoryImpl(this.datasource);
 
  @override
  Future<Carrito> deleteDetallePedido({required String idCarrito, required String idDetalle, required Carrito cart}) {
    return datasource.deleteDetallePedido(idCarrito: idCarrito, idDetalle: idDetalle, cart: cart);
  }

  @override
  Future<Carrito> getCarritoByIdCliente({required String idCliente}) {
    return datasource.getCarritoByIdCliente(idCliente: idCliente);
  }

  @override
  Future<Carrito> updateDetallePedido({required Carrito carrito, required String idDetalle, required int cantidad}) {
    return datasource.updateDetallePedido(carrito: carrito, cantidad: cantidad, idDetalle:  idDetalle);
  }
  
  @override
  Future<void> createOrUpdateDetallePedido({String? idCarrito, required Cliente cliente, required DetallePedido detallePedido}) {
    return datasource.createOrUpdateDetallePedido(idCarrito: idCarrito, cliente: cliente, detallePedido: detallePedido);
  }
  
  @override
  Future<void> deleteCart({required String idCarrito, required Carrito cart}) {
    return datasource.deleteCart(idCarrito: idCarrito, cart: cart);
  }
  
  @override
  Future<Carrito> getCarritoById({required String idCarrito}) {
    return datasource.getCarritoById(idCarrito: idCarrito);
  }
}