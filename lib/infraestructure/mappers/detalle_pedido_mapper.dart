import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/plato_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/detalle_pedido_model.dart';

class DetallePedidoMapper{
  static DetallePedido detallePedidoToEntity(DetallePedidoModel item) => DetallePedido(
    id: item.id,
    plato: PlatoMapper.platoToEntity(item.plato), 
    cantidadPlato: item.cantidadPlato, 
    valorTotal: item.valorTotal
  );

  static DetallePedidoModel detallePedidoToModel(DetallePedido item) => DetallePedidoModel(
    id: item.id,
    plato: PlatoMapper.platoToModel(item.plato), 
    cantidadPlato: item.cantidadPlato, 
    valorTotal: item.valorTotal
  );

}