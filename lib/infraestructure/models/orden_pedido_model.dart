import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_carreta_express_cs/infraestructure/models/cliente_model.dart';
import 'package:la_carreta_express_cs/infraestructure/models/detalle_pedido_model.dart';
import 'package:la_carreta_express_cs/infraestructure/models/empleado_model.dart';

class OrdenPedidoModel {
  final String id;
  final ClienteModel cliente;
  final List<DetallePedidoModel> detalles;
  final String estado;
  final DateTime fecha;
  final EmpleadoModel mesero;
  final int numMesa;
  final String numOrden;
  final double total;
  final String observaciones;
  final String tiempoEstimado;
  final bool statusPago;

  OrdenPedidoModel({
    required this.id,
    required this.cliente,
    required this.detalles,
    required this.estado,
    required this.fecha,
    required this.mesero,
    required this.numMesa,
    required this.numOrden,
    required this.total,
    required this.tiempoEstimado,
    required this.statusPago,
    required this.observaciones
  });

  String toRawJson() => json.encode(toJson());

  factory OrdenPedidoModel.fromJson(String id, Map<String, dynamic> json) => OrdenPedidoModel(
    id: id,
    cliente: ClienteModel.fromJson(json["cliente"]['id'],json["cliente"]),
    detalles: List<DetallePedidoModel>.from(json["detalles"].map((x) => DetallePedidoModel.fromJson(x))),
    estado: json["estado"],
    fecha: json["fecha"] != null ? (json["fecha"] as Timestamp).toDate() : DateTime.now(),
    mesero: EmpleadoModel.fromJson(json["mesero"]),
    numMesa: json["numMesa"],
    numOrden: json["numOrden"],
    tiempoEstimado: json["tiempoEstimado"],   
    total: json["total"]?.toDouble(),
    statusPago: json["statusPago"],
    observaciones: json['observaciones']
  );

    Map<String, dynamic> toJson() => {
      "cliente": cliente.toJson(),
      "detalles": List<dynamic>.from(detalles.map((x) => x.toJson())),
      "estado": estado,
      "fecha": Timestamp.fromDate(fecha),
      "mesero": mesero.toJson(),
      "numMesa": numMesa,
      "numOrden": numOrden,
      "tiempoEstimado": tiempoEstimado,
      "total": total,
      "statusPago": statusPago,
      "observaciones": observaciones
    };
}



