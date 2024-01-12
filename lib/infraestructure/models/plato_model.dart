import 'dart:convert';

import 'package:la_carreta_express_cs/infraestructure/models/categoria_model.dart';

class PlatoModel {
  final String id;
  final CategoriaModel categoria;
  final String descripcion;
  final String descripcionCorta;
  final bool disponibilidad;
  final String imgUrl;
  final String nombre;
  final int numCalorias;
  final bool popular;
  final double precio;
  final String? tiempoPreparacion;

  PlatoModel({
    required this.id,
    required this.categoria,
    required this.descripcion,
    required this.descripcionCorta,
    required this.disponibilidad,
    required this.imgUrl,
    required this.nombre,
    required this.numCalorias,
    required this.popular,
    required this.precio,
    this.tiempoPreparacion,
  });

    String toRawJson() => json.encode(toJson());

  factory PlatoModel.fromJson(String id, Map<String, dynamic> json) => PlatoModel(
    id: id,
    categoria: CategoriaModel.fromJson(json["categoria"]["id"],json["categoria"]),
    descripcion: json["descripcion"],
    descripcionCorta: json["descripcionCorta"],
    disponibilidad: json["disponibilidad"],
    imgUrl: json["imgUrl"],
    nombre: json["nombre"],
    numCalorias: json["numCalorias"],
    popular: json["popular"],
    precio: json["precio"]?.toDouble(),
    tiempoPreparacion: json["tiempoPreparacion"],
  );

    Map<String, dynamic> toJson() => {
      "categoria": categoria.toJson(),
      "descripcion": descripcion,
      "descripcionCorta": descripcionCorta,
      "disponibilidad": disponibilidad,
      "imgUrl": imgUrl,
      "nombre": nombre,
      "numCalorias": numCalorias,
      "popular": popular,
      "precio": precio,
      "tiempoPreparacion": tiempoPreparacion,
  };
}
