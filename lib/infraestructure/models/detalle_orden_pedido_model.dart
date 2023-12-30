import 'dart:convert';

import 'package:la_carreta_express_cs/domain/entities/detalle_orden_pedido.dart';

class DetalleOrdenPedidoModel {
  int idDet;
  String numOrdenOrd;
  String nombrePla;
  String descripcionPla;
  String imgUrlPla;
  int cantidadDet;
  double precioPla;
  double valorTotalDet;

  DetalleOrdenPedidoModel({
    required this.idDet,
    required this.numOrdenOrd,
    required this.nombrePla,
    required this.descripcionPla,
    required this.imgUrlPla,
    required this.cantidadDet,
    required this.precioPla,
    required this.valorTotalDet,
  });

  factory DetalleOrdenPedidoModel.fromRawJson(String str) => DetalleOrdenPedidoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetalleOrdenPedidoModel.fromJson(Map<String, dynamic> json) => DetalleOrdenPedidoModel(
    idDet: json["id_det"],
    numOrdenOrd: json["num_orden_ord"],
    nombrePla: json["nombre_pla"],
    descripcionPla: json["descripcion_pla"],
    imgUrlPla: json["img_url_pla"],
    cantidadDet: json["cantidad_det"],
    precioPla: json["precio_pla"].toDouble() ?? "0.00",
    valorTotalDet: json["valor_total_det"]?.toDouble(),
  );

  // TODO: Generar la logica que manejaria al crear un detalle
  Map<String, dynamic> toJson() => {
    "id_orden_det": 0,
    "id_plato_det": 0,
    "cantidad_det": cantidadDet,
    "valor_total_det": valorTotalDet,
  };

  DetalleOrdenPedido toDetallePedidoEntity() => DetalleOrdenPedido(
    numOrden: numOrdenOrd, 
    nombre: nombrePla, 
    descripcion: descripcionPla, 
    imgUrl: imgUrlPla, 
    cantidad: cantidadDet, 
    precio: precioPla, 
    valorTotal: valorTotalDet
  );  

}
