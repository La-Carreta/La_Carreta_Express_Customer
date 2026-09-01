import 'package:la_carreta_express_cs/domain/datasource/platos_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/infraestructure/http/api_client.dart';

class PlatoDatasourceImpl extends PlatosDatasource {
  final ApiClient _api = ApiClient.instance;

  @override
  Future<List<Plato>> getPlatos() async {
    _assertRestaurantContext();
    final response = await _api.request(
      'GET',
      '/customer/tenants/${ApiClient.tenantId}/catalog?branchId=${Uri.encodeQueryComponent(ApiClient.branchId)}',
    ) as Map<String, dynamic>;
    final products = response['products'] as List<dynamic>? ?? const [];
    return Future.wait(products.map((raw) => _mapProduct(
          raw as Map<String, dynamic>,
        )));
  }

  @override
  Future<List<Plato>> getPlatosByCategoria(String categoria) async =>
      (await getPlatos())
          .where((plate) => plate.categoria.nombre == categoria)
          .toList();

  @override
  Future<Plato> getPlatoById(String id) async =>
      (await getPlatos()).firstWhere((plate) => plate.id == id);

  Future<Plato> _mapProduct(Map<String, dynamic> json) async {
    final category = json['category'] as Map<String, dynamic>;
    final images = json['images'] as List<dynamic>? ?? const [];
    var imageUrl = '';
    if (images.isNotEmpty) {
      final assetId =
          (images.first as Map<String, dynamic>)['assetId'] as String;
      final delivery = await _api.request(
        'GET',
        '/customer/tenants/${ApiClient.tenantId}/media/$assetId/delivery-url',
      ) as Map<String, dynamic>;
      imageUrl = delivery['url'] as String;
    }
    return Plato(
      id: json['id'] as String,
      nombre: json['name'] as String,
      descripcion: json['description']?.toString() ?? '',
      descripcionCorta: json['sku'] as String,
      precio: double.parse(json['effectivePrice'] as String),
      disponibilidad: true,
      tiempoPreparacion: '',
      categoria: Categoria(
        id: category['id'] as String,
        nombre: category['name'] as String,
        imgUrl: '',
      ),
      platoUrl: imageUrl,
      popular: false,
      numCalorias: 0,
    );
  }

  void _assertRestaurantContext() {
    if (ApiClient.tenantId.isEmpty || ApiClient.branchId.isEmpty) {
      throw ApiException('TENANT_ID y BRANCH_ID son obligatorios');
    }
  }
}
