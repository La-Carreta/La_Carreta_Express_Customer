import 'dart:convert';

import 'package:la_carreta_express_cs/infraestructure/models/plato_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class DetallePedidoModel {
  final int cantidadPlato;
  final double valorTotal;
  final PlatoModel plato;
  final String id;

  DetallePedidoModel({
    this.id = "",
    required this.cantidadPlato,
    required this.valorTotal,
    required this.plato,
  });

  factory DetallePedidoModel.fromRawJson(String str) => DetallePedidoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetallePedidoModel.fromJson(Map<String, dynamic> json) => DetallePedidoModel(
    id: json["id"],
    cantidadPlato: json["cantidadPlato"],
    valorTotal: json["valorTotal"]?.toDouble(),
    plato: PlatoModel.fromJson(json['id'],json["plato"]),
  );

  Map<String, dynamic> toJson() => {
    "id": uuid.v4(),
    "cantidadPlato": cantidadPlato,
    "valorTotal": valorTotal,
    "plato": plato.toJson(),
  };
}
