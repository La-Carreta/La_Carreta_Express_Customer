
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';

abstract class CategoriasDatasource{
  Future<List<Categoria>> getCategorias();  
}