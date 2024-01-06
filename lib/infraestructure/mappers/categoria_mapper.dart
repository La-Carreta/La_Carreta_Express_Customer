import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'package:la_carreta_express_cs/infraestructure/models/categoria_model.dart';

class CategoriaMapper{
  static Categoria categoriaToEntity(CategoriaModel categoriaModel) => Categoria(
    id: categoriaModel.id, 
    nombre: categoriaModel.nombre, 
    urlImg: categoriaModel.imgUrl
  );
}