import 'dart:convert';

class MeseroModel {
    final String id;
    final String nombre;
    final String apellido;
    final String estado;
    final String email;
    final String imgUrl;
    final String uuid;
    final DateTime fechaContratacion;
    final String seccion;

    MeseroModel({
        required this.id,
        required this.nombre,
        required this.apellido,
        required this.estado,
        required this.email,
        required this.imgUrl,
        required this.uuid,
        required this.fechaContratacion,
        required this.seccion,
    });

    factory MeseroModel.fromRawJson(String str) => MeseroModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MeseroModel.fromJson(Map<String, dynamic> json) => MeseroModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        estado: json["estado"],
        email: json["email"],
        imgUrl: json["imgUrl"],
        uuid: json["uuid"],
        fechaContratacion: DateTime.parse(json["fechaContratacion"]),
        seccion: json["seccion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "estado": estado,
        "email": email,
        "imgUrl": imgUrl,
        "uuid": uuid,
        "fechaContratacion": "${fechaContratacion.year.toString().padLeft(4, '0')}-${fechaContratacion.month.toString().padLeft(2, '0')}-${fechaContratacion.day.toString().padLeft(2, '0')}",
        "seccion": seccion,
    };
}
