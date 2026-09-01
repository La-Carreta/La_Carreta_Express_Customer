import 'package:la_carreta_express_cs/domain/datasource/orden_pedido_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/estimated_time.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/domain/repositories/orden_pedido_repository.dart';

class OrdenPedidoRepositoryImp extends OrdenPedidoRepository {
  final OrdenPedidoDatasource datasource;

  OrdenPedidoRepositoryImp(this.datasource);

  @override
  Future<void> createOrder({required OrdenPedido order}) {
    return datasource.createOrder(order: order);
  }

  @override
  Stream<OrdenPedido> getOrderById({required String idOrdenPedido}) {
    return datasource.getOrderById(idOrdenPedido: idOrdenPedido);
  }

  @override
  Stream<List<OrdenPedido>> getOrdersByCustomer({required String idCliente}) {
    return datasource.getOrdersByCustomer(idCliente: idCliente);
  }

  @override
  Stream<List<OrdenPedido>> getOrdersByFilter(
      {required String idCliente, required String state}) {
    return datasource.getOrdersByFilter(idCliente: idCliente, state: state);
  }

  @override
  Future<void> cancelOrder({required String idOrdenPedido}) {
    return datasource.cancelOrder(idOrdenPedido: idOrdenPedido);
  }

  @override
  Future<void> deleteOrder({required String idOrdenPedido}) {
    return datasource.deleteOrder(idOrdenPedido: idOrdenPedido);
  }

  @override
  Future<EstimatedTime> getEstimatedTime() {
    return datasource.getEstimatedTime();
  }
}
