import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';

class Factura {
  final String id;
  final OrdenPedido ordenPedido;
  final DateTime fechaEmision;
  final String estadoFactura;
  final double costoTotal;

  Factura(
      {this.id = "",
      required this.ordenPedido,
      required this.fechaEmision,
      required this.estadoFactura,
      required this.costoTotal});
}
