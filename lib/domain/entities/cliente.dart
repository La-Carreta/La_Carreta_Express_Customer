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

  //TODO: Eliminar id
  Cliente.empty():
    id = "DkkkqnIBV5OTH2s4eNJW",
    nombre = "",
    apellido = "",
    celular = "",
    correo = "",
    direccion = "",
    imgUrl = '',
    uuid = "";
}