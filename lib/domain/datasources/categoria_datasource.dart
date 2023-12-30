import 'package:la_carreta_express_cs/domain/entities/categoria.dart';

abstract class CategoriaDataSource{
  Future<List<Categoria>> getCategorias();  
}