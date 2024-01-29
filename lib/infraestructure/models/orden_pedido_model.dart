import 'dart:convert';
import 'package:la_carreta_express_cs/infraestructure/models/cliente_model.dart';
import 'package:la_carreta_express_cs/infraestructure/models/detalle_pedido_model.dart';
import 'package:la_carreta_express_cs/infraestructure/models/empleado_model.dart';

class OrdenPedidoModel {
  final String id;
  final ClienteModel cliente;
  final List<DetallePedidoModel> detalles;
  final String estado;
  final DateTime fecha;
  final DateTime fechaAprobacion;
  final EmpleadoModel mesero;
  final int numMesa;
  final String numOrden;
  final double total;
  final String observaciones;

  OrdenPedidoModel({
    required this.id,
    required this.cliente,
    required this.detalles,
    required this.estado,
    required this.fecha,
    required this.fechaAprobacion,
    required this.mesero,
    required this.numMesa,
    required this.numOrden,
    required this.total,
    required this.observaciones
  });

  String toRawJson() => json.encode(toJson());

  factory OrdenPedidoModel.fromJson(String id, Map<String, dynamic> json) => OrdenPedidoModel(
    id: id,
    cliente: ClienteModel.fromJson(json["cliente"]['id'],json["cliente"]),
    detalles: List<DetallePedidoModel>.from(json["detalles"].map((x) => DetallePedidoModel.fromJson(x))),
    estado: json["estado"],
    fecha: DateTime.parse(json["fecha"]),
    fechaAprobacion: DateTime.parse(json["fechaAprobacion"]),
    mesero: EmpleadoModel.fromJson(json["mesero"]),
    numMesa: json["numMesa"],
    numOrden: json["numOrden"],
    total: json["total"]?.toDouble(),
    observaciones: json['observaciones']
  );

    Map<String, dynamic> toJson() => {
      "cliente": cliente.toJson(),
      "detalles": List<dynamic>.from(detalles.map((x) => x.toJson())),
      "estado": estado,
      "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
      "fechaAprobacion": "${fechaAprobacion.year.toString().padLeft(4, '0')}-${fechaAprobacion.month.toString().padLeft(2, '0')}-${fechaAprobacion.day.toString().padLeft(2, '0')}",
      "mesero": mesero.toJson(),
      "numMesa": numMesa,
      "numOrden": numOrden,
      "total": total,
      "observaciones": observaciones
    };
}




