class Cliente{
  final String id;
  final String nombre;
  final String apellido;
  final String celular;
  final String correo;
  final String direccion;
  final String uuid;
  final String imgUrl;

  Cliente({
    this.id = "", 
    required this.nombre, 
    required this.apellido, 
    required this.celular, 
    required this.correo, 
    required this.direccion,
    required this.imgUrl,
    required this.uuid
  });

  Cliente.empty():
    id = "",
    nombre = "",
    apellido = "",
    celular = "",
    correo = "",
    direccion = "",
    imgUrl = '',
    uuid = "";

  Cliente copyWith({
    String? id,
    String? nombre, 
    String? apellido, 
    String? celular, 
    String? correo, 
    String? direccion,
    String? imgUrl,
    String? uuid
  }){
    return Cliente(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre, 
      apellido: apellido ?? this.apellido, 
      celular: celular ?? this.celular, 
      correo: correo ?? this.correo, 
      direccion: direccion ?? this.direccion, 
      imgUrl: imgUrl ?? this.imgUrl, 
      uuid: uuid ?? this.uuid
    );
  }
}