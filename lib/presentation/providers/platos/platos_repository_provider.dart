import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/infraestructure/datasource/plato_datasource.dart';
import 'package:la_carreta_express_cs/infraestructure/repositories/plato_repository_imp.dart';

final platoRepositoryProvider = Provider((ref){
  return PlatoRepositoryImp( PlatoDatasource() );
});
