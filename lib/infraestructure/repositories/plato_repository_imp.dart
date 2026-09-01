import 'package:la_carreta_express_cs/domain/datasource/platos_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/domain/repositories/platos_repository.dart';

class PlatoRepositoryImp extends PlatosRepository {
  final PlatosDatasource datasource;

  PlatoRepositoryImp(this.datasource);

  @override
  Future<List<Plato>> getPlatos() {
    return datasource.getPlatos();
  }

  @override
  Future<List<Plato>> getPlatosByCategoria(String categoria) {
    return datasource.getPlatosByCategoria(categoria);
  }

  @override
  Future<Plato> getPlatoById(String id) {
    return datasource.getPlatoById(id);
  }
}
