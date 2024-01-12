import 'package:la_carreta_express_cs/domain/entities/plato.dart';

class DetallePedido{
  final String id;
  final Plato plato;
  final int cantidadPlato;
  final double valorTotal;

  DetallePedido({
    this.id = "", 
    required this.plato, 
    required this.cantidadPlato, 
    required this.valorTotal
  });
 
}