import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/cliente_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/detalle_pedido_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/mesero_mappper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/orden_pedido_model.dart';

class OrdenPedidoMapper{

  static OrdenPedidoModel ordenPedidoToModel(OrdenPedido order) => OrdenPedidoModel(
    id: order.id, 
    cliente: ClienteMapper.clienteToModel(order.cliente), 
    total: order.costoTotalPedido,
    detalles: order.detalles.map((item) => DetallePedidoMapper.detallePedidoToModel(item)).toList(),
    estado: order.estadoOrden,
    fecha: order.fechaEmision,
    mesero: MeseroMapper.empleadoToModel(order.mesero),
    numMesa: order.numMesa,
    numOrden: order.numOrden,
    tiempoEstimado: order.tiempoEstimado,
    observaciones: order.observaciones
  );

  static OrdenPedido ordenPedidoToEntity(OrdenPedidoModel order) => OrdenPedido(
    id: order.id, 
    cliente: ClienteMapper.clienteToEntity(order.cliente), 
    costoTotalPedido: order.total,
    detalles: order.detalles.map((item) => DetallePedidoMapper.detallePedidoToEntity(item)).toList(),
    mesero: MeseroMapper.empleadoToEntity(order.mesero),
    numMesa: order.numMesa,
    numOrden: order.numOrden,
    tiempoEstimado: order.tiempoEstimado,
    fechaEmision: order.fecha,
    observaciones: order.observaciones, 
    estadoOrden: order.estado
  );
}