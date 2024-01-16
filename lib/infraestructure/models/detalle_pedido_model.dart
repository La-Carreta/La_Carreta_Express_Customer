import 'dart:convert';

import 'package:la_carreta_express_cs/infraestructure/models/plato_model.dart';

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
      cantidadPlato: json["cantidadPlato"],
      valorTotal: json["valorTotal"]?.toDouble(),
      plato: PlatoModel.fromJson(json['id'],json["plato"]),
    );

    Map<String, dynamic> toJson() => {
      "cantidadPlato": cantidadPlato,
      "valorTotal": valorTotal,
      "plato": plato.toJson(),
    };
}
