import 'dart:convert';

class EmpleadoModel {
  final String id;
  final String apellido;
  final String areaTrabajo;
  final String celular;
  final String email;
  final String estado;
  final DateTime fechaContratacion;
  final String nombre;
  final String imgUrl;
  final String uuid;

  EmpleadoModel({
    required this.id,
    required this.apellido,
    required this.email,
    required this.estado,
    required this.fechaContratacion,
    required this.nombre,
    required this.areaTrabajo,
    required this.celular,
    required this.imgUrl,
    required this.uuid,
  });

  EmpleadoModel copyWith({
    String? id,
    String? apellido,
    String? email,
    String? estado,
    DateTime? fechaContratacion,
    String? nombre,
    String? areaTrabajo,
    String? celular,
    String? imgUrl,
    String? uuid,
  }) =>
      EmpleadoModel(
        id: id ?? this.id,
        apellido: apellido ?? this.apellido,
        email: email ?? this.email,
        estado: estado ?? this.estado,
        fechaContratacion: fechaContratacion ?? this.fechaContratacion,
        nombre: nombre ?? this.nombre,
        areaTrabajo: areaTrabajo ?? this.areaTrabajo,
        celular: celular ?? this.celular,
        imgUrl: imgUrl ?? this.imgUrl,
        uuid: uuid ?? this.uuid,
      );

  factory EmpleadoModel.fromRawJson(String str) =>
      EmpleadoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmpleadoModel.fromJson(Map<String, dynamic> json) => EmpleadoModel(
        id: json["id"],
        apellido: json["apellido"],
        email: json["email"],
        estado: json["estado"],
        fechaContratacion: json["fechaContratacion"] != null
            ? DateTime.parse(json["fechaContratacion"] as String)
            : DateTime.now(),
        nombre: json["nombre"],
        areaTrabajo: json["areaTrabajo"],
        celular: json["celular"],
        imgUrl: json["imgUrl"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "apellido": apellido,
        "email": email,
        "estado": estado,
        "fechaContratacion": fechaContratacion.toIso8601String(),
        "nombre": nombre,
        "areaTrabajo": areaTrabajo,
        "celular": celular,
        "imgUrl": imgUrl,
        "uuid": uuid,
      };
}
