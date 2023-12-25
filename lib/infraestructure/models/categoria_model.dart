import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'dart:convert';

class CategoriaModel {
  int idCat;
  String nombreCat;
  String descripcionCat;

  CategoriaModel({
    required this.idCat,
    required this.nombreCat,
    required this.descripcionCat,
  });

  factory CategoriaModel.fromRawJson(String str) => CategoriaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
    idCat: json["id_cat"],
    nombreCat: json["nombre_cat"],
    descripcionCat: json["descripcion_cat"],
  );

  Map<String, dynamic> toJson() => {
    "id_cat": idCat,
    "nombre_cat": nombreCat,
    "descripcion_cat": descripcionCat,
  };


  Categoria toCategoriaEntity() => Categoria(
    id: idCat,
    nombre: nombreCat,
    descripcion: descripcionCat
  );

}

