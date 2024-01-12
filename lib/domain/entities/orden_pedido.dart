import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';

class OrdenPedido{
  final String id;
  final String nombreCliente;
  final DateTime fechaEmision;
  final String estadoOrden;
  final String nombreMesero;
  final double costoTotalPedido;
  final String numOrden;
  final String observaciones;
  final int numMesa;
  final List<DetallePedido> detalles;

  OrdenPedido({
    this.id = "", 
    required this.nombreCliente, 
    required this.fechaEmision, 
    required this.estadoOrden, 
    required this.nombreMesero, 
    required this.costoTotalPedido, 
    required this.numOrden, 
    required this.observaciones, 
    required this.numMesa,
    required this.detalles
  });
}