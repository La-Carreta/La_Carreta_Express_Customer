import 'package:la_carreta_express_cs/domain/datasources/detalle_orden_pedido_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_orden_pedido.dart';
import 'package:la_carreta_express_cs/infraestructure/models/detalle_orden_pedido_model.dart';
import 'package:la_carreta_express_cs/shared/data/detalle_pedido.dart';

class DetallePedidoDataSourceImp implements DetalleOrdenPedidoDataSource{

  @override
  Future<void> createDetalleCarrito() {
    // TODO: implement createDetalleCarrito
    throw UnimplementedError();
  }

  @override
  Future<void> deleteDetalleCarrito() {
    // TODO: implement deleteDetalleCarrito
    throw UnimplementedError();
  }

  @override
  Future<List<DetalleOrdenPedido>> getDetallesCarrito() async{
    await Future.delayed(const Duration(seconds: 2));
    final List<DetalleOrdenPedido> detallesPedido = detallesCarito.map((detalle) => DetalleOrdenPedidoModel.fromJson(detalle).toDetallePedidoEntity()).toList();
    return detallesPedido;
  }

  //TODO: Se gestiona localmente  
  @override
  Future<DetalleOrdenPedido> updateDetalleCarritoById(int id, int cantidad) async{
    final List<DetalleOrdenPedido> detallesPedido = detallesCarito.map((detalle) => DetalleOrdenPedidoModel.fromJson(detalle).toDetallePedidoEntity()).toList();
    DetalleOrdenPedido detPedido = detallesPedido.firstWhere((pedido) => pedido.id == id);
    detPedido.cantidad = cantidad;
    detPedido.valorTotal = cantidad * detPedido.precio;
    
    return detPedido;
  }

}