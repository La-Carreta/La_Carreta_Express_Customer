import 'package:la_carreta_express_cs/domain/datasource/orden_pedido_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/domain/repositories/orden_pedido_repository.dart';

class OrdenPedidoRepositoryImp extends OrdenPedidoRepository{

  final OrdenPedidoDatasource datasource;

  OrdenPedidoRepositoryImp(this.datasource);

  @override
  Future<void> cancelOrder({required OrdenPedido order}) {
    return datasource.cancelOrder(order: order);
  }

  @override
  Future<void> createOrder({required OrdenPedido order}) {
    return datasource.createOrder(order: order);
  }

  @override
  Future<OrdenPedido> getOrderById({required String idOrdenPedido}) {
    return datasource.getOrderById(idOrdenPedido: idOrdenPedido);
  }

  @override
  Future<List<OrdenPedido>> getOrdersByCustomer({required String idCliente}) {
    return datasource.getOrdersByCustomer(idCliente: idCliente);
  }

}
