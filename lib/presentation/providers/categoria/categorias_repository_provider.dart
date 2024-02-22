import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/infraestructure/datasource/categoria_datasource_impl.dart';
import 'package:la_carreta_express_cs/infraestructure/repositories/categoria_repository_impl.dart';

final categoriaRepositoryProvider = Provider((ref){
  return CategoriaRepositoryImp( CategoriaDatasourceImpl() );
});

