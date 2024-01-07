class Plato{
  final String id;
  final String nombre;
  final String descripcion;
  final String descripcionCorta;
  final double precio;
  final bool disponibilidad;
  final String tiempoPreparacion;
  final String categoria;
  final String platoUrl;
  final bool popular;

  Plato({
    this.id = "",
    required this.nombre, 
    required this.descripcion, 
    required this.descripcionCorta, 
    required this.precio, 
    required this.disponibilidad, 
    required this.tiempoPreparacion, 
    required this.categoria, 
    required this.platoUrl,
    required this.popular
  }); 
}