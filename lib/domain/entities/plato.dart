class Plato{
  final int id;
  final String nombre;
  final String descripcion;
  final double precio;
  final bool disponibilidad;
  final String tiempoPreparacion;
  final String categoria;
  final String platoUrl;

  Plato({
    this.id = 0, 
    required this.nombre, 
    required this.descripcion, 
    required this.precio, 
    required this.disponibilidad, 
    required this.tiempoPreparacion, 
    required this.categoria, 
    required this.platoUrl
  });
  
}