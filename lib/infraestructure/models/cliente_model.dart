import 'dart:convert';

class ClienteModel {
    final String id;
    final String nombre;
    final String apellido;
    final String celular;
    final String direccion;
    final String email;
    final String imgUrl;
    final String uuid;

    ClienteModel({
        this.id = "",
        required this.nombre,
        required this.apellido,
        required this.celular,
        required this.direccion,
        required this.email,
        required this.imgUrl,
        required this.uuid,
    });

    factory ClienteModel.fromRawJson(String str) => ClienteModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        celular: json["celular"],
        direccion: json["direccion"],
        email: json["email"],
        imgUrl: json["imgUrl"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "celular": celular,
        "direccion": direccion,
        "email": email,
        "imgUrl": imgUrl,
        "uuid": uuid,
    };
}
