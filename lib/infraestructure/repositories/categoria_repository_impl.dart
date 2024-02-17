import 'package:la_carreta_express_cs/domain/datasource/categorias_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'package:la_carreta_express_cs/domain/repositories/categorias_repository.dart';

class CategoriaRepositoryImp extends CategoriasRepository{

  final CategoriasDatasource datasource;

  CategoriaRepositoryImp(this.datasource);
  
  @override
  Future<List<Categoria>> getCategorias(){
    return datasource.getCategorias();
  }

}