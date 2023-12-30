import 'package:la_carreta_express_cs/domain/datasources/detalle_orden_pedido_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_orden_pedido.dart';
import 'package:la_carreta_express_cs/domain/respositories/detalle_orden_pedido_repository.dart';

class DetalleOrdenPedidoRepositoryImp implements DetalleOrdenPedidoRepository{

  final DetalleOrdenPedidoDataSource detalleOrdenPedidoDataSource;

  DetalleOrdenPedidoRepositoryImp({required this.detalleOrdenPedidoDataSource});

  @override
  Future<void> createDetalleCarrito() {
    return detalleOrdenPedidoDataSource.createDetalleCarrito();
  }

  @override
  Future<void> deleteDetalleCarrito() {
    return detalleOrdenPedidoDataSource.deleteDetalleCarrito();
  }

  @override
  Future<List<DetalleOrdenPedido>> getDetallesCarrito() {
    return detalleOrdenPedidoDataSource.getDetallesCarrito();
  }

  @override
  Future<DetalleOrdenPedido> updateDetalleCarritoById(int id, int cantidad) {
    return detalleOrdenPedidoDataSource.updateDetalleCarritoById(id, cantidad);
  } 

}
