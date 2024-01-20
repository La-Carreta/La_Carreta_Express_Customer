import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';

class Carrito{
  final String id;
  final List<DetallePedido> detallesPedido;
  final Cliente cliente;

  Carrito({
    this.id = "", 
    required this.detallesPedido, 
    required this.cliente
  }); 

  Carrito.empty():
    id = "",
    detallesPedido = [],
    cliente = Cliente.empty();
}