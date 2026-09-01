import 'package:la_carreta_express_cs/domain/datasource/categorias_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'package:la_carreta_express_cs/infraestructure/datasource/plato_datasource_impl.dart';

class CategoriaDatasourceImpl extends CategoriasDatasource {
  @override
  Future<List<Categoria>> getCategorias() async {
    final products = await PlatoDatasourceImpl().getPlatos();
    final categories = <String, Categoria>{};
    for (final product in products) {
      categories[product.categoria.id] = product.categoria;
    }
    return categories.values.toList();
  }
}
