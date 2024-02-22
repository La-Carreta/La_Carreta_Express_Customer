import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/infraestructure/datasource/cliente_datasource_imp.dart';
import 'package:la_carreta_express_cs/infraestructure/repositories/cliente_repository_imp.dart';

final clienteRepositoryProvider = Provider((ref){
  return ClienteRepositoryImp( ClienteDataSourceImpl() );
});