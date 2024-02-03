import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/domain/entities/mesero.dart';

class OrdenPedido{
  final String id;
  final Cliente cliente;
  final DateTime fechaEmision;
  final String estadoOrden;
  final Mesero mesero;
  final double costoTotalPedido;
  final String numOrden;
  final String observaciones;
  final int numMesa;
  final List<DetallePedido> detalles;
  final String tiempoEstimado;

  OrdenPedido({
    this.id = "", 
    required this.cliente, 
    required this.fechaEmision, 
    this.estadoOrden = "Pedido realizado", 
    this.tiempoEstimado = "",
    required this.mesero, 
    required this.costoTotalPedido, 
    required this.numOrden, 
    required this.observaciones, 
    required this.numMesa,
    required this.detalles
  });

  OrdenPedido copyWith({
    String? id,
    Cliente? cliente,
    DateTime? fechaEmision,
    String? estadoOrden,
    Mesero? mesero,
    double? costoTotalPedido,
    String? numOrden,
    String? observaciones,
    int? numMesa,
    List<DetallePedido>? detalles,
    String? tiempoEstimado,
  }) {
    return OrdenPedido(
      id: id ?? this.id,
      cliente: cliente ?? this.cliente,
      fechaEmision: fechaEmision ?? this.fechaEmision,
      estadoOrden: estadoOrden ?? this.estadoOrden,
      mesero: mesero ?? this.mesero,
      costoTotalPedido: costoTotalPedido ?? this.costoTotalPedido,
      numOrden: numOrden ?? this.numOrden,
      observaciones: observaciones ?? this.observaciones,
      numMesa: numMesa ?? this.numMesa,
      detalles: detalles ?? this.detalles,
      tiempoEstimado: tiempoEstimado ?? this.tiempoEstimado,
    );
  }

  OrdenPedido.empty():
    id = "", 
    cliente = Cliente.empty(), 
    fechaEmision = DateTime.now(), 
    estadoOrden = "Pedido realizado", 
    tiempoEstimado = "",
    mesero = Mesero.empty(), 
    costoTotalPedido = 0, 
    numOrden = "", 
    observaciones = "", 
    numMesa = 0,
    detalles = <DetallePedido>[];

}