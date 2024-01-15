import 'package:la_carreta_express_cs/domain/datasource/carrito_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/domain/repositories/carrito_repository.dart';

class CarritoRepositoryImpl extends CarritoRepository{
  final CarritoDatasource datasource;

  CarritoRepositoryImpl(this.datasource);

  @override
  Future<void> deleteDetallePedido(String idDetalle) {
    return datasource.deleteDetallePedido(idDetalle);
  }

  @override
  Future<List<DetallePedido>> getCarrito() {
    return datasource.getCarrito();
  }

  @override
  Future<void> updateDetallePedido(String idDetalle, int cantidad) {
    return updateDetallePedido(idDetalle, cantidad);
  }
}