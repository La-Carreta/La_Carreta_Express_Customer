import 'dart:convert';

import 'package:la_carreta_express_cs/infraestructure/models/cliente_model.dart';
import 'package:la_carreta_express_cs/infraestructure/models/detalle_pedido_model.dart';

class CarritoModel {
  final String id;
  final ClienteModel cliente;
  final List<DetallePedidoModel> detallesPedido;
  final double total;

  CarritoModel(
      {required this.id,
      required this.cliente,
      required this.detallesPedido,
      required this.total});

  CarritoModel copyWith({
    String? id,
    ClienteModel? cliente,
    List<DetallePedidoModel>? detallesPedido,
    double? total,
  }) =>
      CarritoModel(
          id: id ?? this.id,
          cliente: cliente ?? this.cliente,
          detallesPedido: detallesPedido ?? this.detallesPedido,
          total: total ?? this.total);

  String toRawJson() => json.encode(toJson());

  factory CarritoModel.fromJson(String id, Map<String, dynamic> json) =>
      CarritoModel(
          id: id,
          cliente:
              ClienteModel.fromJson(json["cliente"]["id"], json["cliente"]),
          detallesPedido: List<DetallePedidoModel>.from(json["detallesPedido"]
              .map((x) => DetallePedidoModel.fromJson(x))),
          total: json['total']?.toDouble());

  Map<String, dynamic> toJson() => {
        "cliente": cliente.toJson(),
        "detallesPedido":
            List<dynamic>.from(detallesPedido.map((x) => x.toJson())),
        "total": total
      };
}
