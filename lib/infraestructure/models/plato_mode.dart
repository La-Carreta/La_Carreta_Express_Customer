import 'dart:convert';

import 'package:la_carreta_express_cs/domain/entities/plato.dart';

class PlatoModel {
  int idPla;
  String nombrePla;
  String descripcionPla;
  double precioPla;
  bool disponibilidadPla;
  String tiempoPreparacionPla;
  String platoUrlPla;
  int idCategoriaPla;

  PlatoModel({
    required this.idPla,
    required this.nombrePla,
    required this.descripcionPla,
    required this.precioPla,
    required this.disponibilidadPla,
    required this.tiempoPreparacionPla,
    required this.platoUrlPla,
    required this.idCategoriaPla,
  });

  factory PlatoModel.fromRawJson(String str) => PlatoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlatoModel.fromJson(Map<String, dynamic> json) => PlatoModel(
    idPla: json["id_pla"],
    nombrePla: json["nombre_pla"],
    descripcionPla: json["descripcion_pla"],
    precioPla: json["precio_pla"]?.toDouble(),
    disponibilidadPla: json["disponibilidad_pla"],
    tiempoPreparacionPla: json["tiempo_preparacion_pla"],
    platoUrlPla: json["plato_url_pla"],
    idCategoriaPla: json["id_categoria_pla"],
  );

  Map<String, dynamic> toJson() => {
    "id_pla": idPla,
    "nombre_pla": nombrePla,
    "descripcion_pla": descripcionPla,
    "precio_pla": precioPla,
    "disponibilidad_pla": disponibilidadPla,
    "tiempo_preparacion_pla": tiempoPreparacionPla,
    "plato_url_pla": platoUrlPla,
    "id_categoria_pla": idCategoriaPla,
  };

  //TODO: Consultar como tener asociado la categoria
  Plato toPlatoEntity() => Plato(
    id: idPla,
    nombre: nombrePla, 
    descripcion: descripcionPla, 
    precio: precioPla, 
    disponibilidad: disponibilidadPla, 
    tiempoPreparacion: tiempoPreparacionPla, 
    categoria: "", 
    platoUrl: platoUrlPla
  );
}
