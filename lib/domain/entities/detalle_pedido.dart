import 'package:la_carreta_express_cs/domain/entities/plato.dart';

class DetallePedido{  
  final String id;
  final int cantidadPlato;
  final double valorTotal;
  final Plato plato;

  DetallePedido({
    this.id = '',
    required this.plato, 
    required this.cantidadPlato, 
    required this.valorTotal
  });

  DetallePedido.empty():
    id = '',
    plato = Plato.empty(),
    cantidadPlato = 0,
    valorTotal = 0.0;

  @override
  String toString(){
    return 'id: $id, cantidad: $cantidadPlato total: $valorTotal, plato: $plato';
  }

  //CopyWith
  static DetallePedido copyWith({
    String? id,
    int? cantidadPlato,
    double? valorTotal,
    Plato? plato
  }) => DetallePedido(
    id: id ?? "",
    plato: plato ?? Plato.empty(), 
    cantidadPlato: cantidadPlato ?? 0, 
    valorTotal: valorTotal ?? 0.0
  );
}
