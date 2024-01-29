import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/domain/entities/mesero.dart';

class OrdenPedido{
  final String id;
  final Cliente cliente;
  final DateTime fechaEmision;
  final DateTime fechaAprobacion;
  final String estadoOrden;
  final Mesero mesero;
  final double costoTotalPedido;
  final String numOrden;
  final String observaciones;
  final int numMesa;
  final List<DetallePedido> detalles;

  OrdenPedido({
    this.id = "", 
    required this.cliente, 
    required this.fechaEmision, 
    required this.fechaAprobacion, 
    this.estadoOrden = "Pedido realizado", 
    required this.mesero, 
    required this.costoTotalPedido, 
    required this.numOrden, 
    required this.observaciones, 
    required this.numMesa,
    required this.detalles
  });
}