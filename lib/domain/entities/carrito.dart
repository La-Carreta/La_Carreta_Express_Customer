import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';

class Carrito{
  final String id;
  final List<DetallePedido> detallesPedido;
  final Cliente cliente;
  final double total;

  Carrito({
    this.id = "", 
    required this.detallesPedido, 
    required this.cliente,
    required this.total
  }); 

  Carrito.empty():
    id = "",
    detallesPedido = [],
    cliente = Cliente.empty(),
    total = 0.0;

  static Carrito copyWith({
    String? id,
    List<DetallePedido>? detallesPedido,
    Cliente? cliente,
    double? total,
  }) => Carrito(
    id: id ?? '',
    detallesPedido: detallesPedido ?? [], 
    cliente: cliente ?? Cliente.empty(), 
    total: total ?? 0.0
  );
}