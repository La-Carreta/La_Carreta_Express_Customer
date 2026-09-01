import 'package:la_carreta_express_cs/domain/entities/carrito.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/cliente_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/detalle_pedido_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/carrito_model.dart';

class CarritoMapper {
  static CarritoModel carritoToModel(Carrito carrito) => CarritoModel(
      id: carrito.id,
      cliente: ClienteMapper.clienteToModel(carrito.cliente),
      detallesPedido: carrito.detallesPedido
          .map((item) => DetallePedidoMapper.detallePedidoToModel(item))
          .toList(),
      total: carrito.total);

  static Carrito carritoToEntity(CarritoModel carrito) => Carrito(
      id: carrito.id,
      cliente: ClienteMapper.clienteToEntity(carrito.cliente),
      detallesPedido: carrito.detallesPedido
          .map((item) => DetallePedidoMapper.detallePedidoToEntity(item))
          .toList(),
      total: carrito.total);
}
