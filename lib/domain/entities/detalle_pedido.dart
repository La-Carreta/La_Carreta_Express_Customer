import 'package:la_carreta_express_cs/domain/entities/plato.dart';

class DetallePedido{
  final String id;
  final int cantidadPlato;
  final double valorTotal;
  final Map<String, dynamic>? platoMap; 

  final Plato? plato;

  DetallePedido({
    this.id = "", 
    this.plato, 
    this.platoMap,
    required this.cantidadPlato, 
    required this.valorTotal
  });

}