
import 'package:hive/hive.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:uuid/uuid.dart';

part 'detalle_pedido.g.dart';

const uuid = Uuid();

@HiveType(typeId: 1)
class DetallePedido{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int cantidadPlato;

  @HiveField(2)
  final double valorTotal;

  @HiveField(3)
  final Plato plato;

  DetallePedido({
    this.id = '',
    required this.plato, 
    required this.cantidadPlato, 
    required this.valorTotal
  });

  DetallePedido.empty():
    id = "",
    plato = Plato.empty(),
    cantidadPlato = 0,
    valorTotal = 0.0;
}