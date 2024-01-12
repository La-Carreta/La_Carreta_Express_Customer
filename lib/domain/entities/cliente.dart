class Cliente{
  final String id;
  final String nombre;
  final String apellido;
  final String celular;
  final String correo;
  final String direccion;

  Cliente({
    this.id = "", 
    required this.nombre, 
    required this.apellido, 
    required this.celular, 
    required this.correo, 
    required this.direccion
  });
}