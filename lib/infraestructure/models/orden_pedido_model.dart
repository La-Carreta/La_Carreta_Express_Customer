import 'dart:convert';
import 'package:la_carreta_express_cs/infraestructure/models/cliente_model.dart';
import 'package:la_carreta_express_cs/infraestructure/models/detalle_pedido_model.dart';
import 'package:la_carreta_express_cs/infraestructure/models/mesero_model.dart';

class OrdenPedidoModel {
  final ClienteModel cliente;
  final List<DetallePedidoModel> detalles;
  final String estado;
  final DateTime fecha;
  final DateTime fechaAprobacion;
  final MeseroModel mesero;
  final int numMesa;
  final String numOrden;
  final double total;

  OrdenPedidoModel({
    required this.cliente,
    required this.detalles,
    required this.estado,
    required this.fecha,
    required this.fechaAprobacion,
    required this.mesero,
    required this.numMesa,
    required this.numOrden,
    required this.total,
  });

  factory OrdenPedidoModel.fromRawJson(String str) => OrdenPedidoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrdenPedidoModel.fromJson(Map<String, dynamic> json) => OrdenPedidoModel(
    cliente: ClienteModel.fromJson(json["cliente"]['id'],json["cliente"]),
    detalles: List<DetallePedidoModel>.from(json["detalles"].map((x) => DetallePedidoModel.fromJson(x))),
    estado: json["estado"],
    fecha: DateTime.parse(json["fecha"]),
    fechaAprobacion: DateTime.parse(json["fechaAprobacion"]),
    mesero: MeseroModel.fromJson(json["mesero"]),
    numMesa: json["numMesa"],
    numOrden: json["numOrden"],
    total: json["total"]?.toDouble(),
  );

    Map<String, dynamic> toJson() => {
      "cliente": cliente.toJson(),
      "detalles": List<DetallePedidoModel>.from(detalles.map((x) => x.toJson())),
      "estado": estado,
      "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
      "fechaAprobacion": "${fechaAprobacion.year.toString().padLeft(4, '0')}-${fechaAprobacion.month.toString().padLeft(2, '0')}-${fechaAprobacion.day.toString().padLeft(2, '0')}",
      "mesero": mesero.toJson(),
      "numMesa": numMesa,
      "numOrden": numOrden,
      "total": total,
    };
}




