import 'package:la_carreta_express_cs/domain/entities/categoria.dart';

class Plato{
  final String id;
  final String nombre;
  final String descripcion;
  final String descripcionCorta;
  final double precio;
  final bool disponibilidad;
  final String tiempoPreparacion;
  final Categoria categoria;
  final String platoUrl;
  final bool popular;
  final int numCalorias;

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
    required this.popular,
    required this.numCalorias
  }); 

  Plato.empty():
    id="",
    nombre = '',
    descripcion = '',
    descripcionCorta = '',
    precio = 0.0,
    disponibilidad = false,
    tiempoPreparacion = '',
    categoria = Categoria.empty(),
    platoUrl = '',
    numCalorias = 0,
    popular = false;

}