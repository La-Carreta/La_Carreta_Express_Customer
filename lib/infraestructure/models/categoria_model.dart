class CategoriaModel {
  //Firebase
  final String id;
  final String nombre;
  final String imgUrl;

  CategoriaModel({
    required this.id,
    required this.nombre,
    required this.imgUrl
  });

  factory CategoriaModel.fromJson(String id, Map<String, dynamic> json) => CategoriaModel(
    id: id == "" ? json['id'] : id,
    nombre: json["nombre"],
    imgUrl: json['imgUrl']    
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "imgUrl": imgUrl,
    "nombre": nombre,
  };
}

