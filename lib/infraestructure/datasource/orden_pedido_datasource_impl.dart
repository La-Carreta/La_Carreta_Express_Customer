import 'package:la_carreta_express_cs/domain/datasource/orden_pedido_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/domain/entities/estimated_time.dart';
import 'package:la_carreta_express_cs/domain/entities/mesero.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/infraestructure/http/api_client.dart';
import 'package:uuid/uuid.dart';

class OrdenPedidoDatasourceImpl extends OrdenPedidoDatasource {
  final ApiClient _api = ApiClient.instance;
  static final Map<String, int> _versions = {};
  static final Map<String, Cliente> _customers = {};

  @override
  Future<void> createOrder({required OrdenPedido order}) async {
    _assertContext();
    final response = await _api.request(
      'POST',
      '/customer/tenants/${ApiClient.tenantId}/orders',
      body: {
        'branchId': ApiClient.branchId,
        'diningTableId': ApiClient.tableId,
        'commandId': const Uuid().v4(),
        'customerFirstName': order.cliente.nombre,
        if (order.cliente.apellido.isNotEmpty)
          'customerLastName': order.cliente.apellido,
        if (order.observaciones.isNotEmpty) 'notes': order.observaciones,
        'items': order.detalles
            .map((item) => {
                  'productId': item.plato.id,
                  'quantity': item.cantidadPlato.toString(),
                })
            .toList(),
      },
    ) as Map<String, dynamic>;
    _customers[response['id'] as String] = order.cliente;
    _mapOrder(response);
  }

  @override
  Stream<OrdenPedido> getOrderById({required String idOrdenPedido}) async* {
    while (true) {
      final response = await _api.request(
        'GET',
        '/customer/tenants/${ApiClient.tenantId}/orders/$idOrdenPedido',
      ) as Map<String, dynamic>;
      yield _mapOrder(response);
      await Future<void>.delayed(const Duration(seconds: 5));
    }
  }

  @override
  Stream<List<OrdenPedido>> getOrdersByCustomer({required String idCliente}) =>
      _orderListStream();

  @override
  Stream<List<OrdenPedido>> getOrdersByFilter({
    required String idCliente,
    required String state,
  }) async* {
    await for (final orders in _orderListStream()) {
      yield orders.where((order) => order.estadoOrden == state).toList();
    }
  }

  Stream<List<OrdenPedido>> _orderListStream() async* {
    while (true) {
      final response = await _api.request(
        'GET',
        '/customer/tenants/${ApiClient.tenantId}/orders',
      ) as List<dynamic>;
      yield response
          .map((raw) => _mapOrder(raw as Map<String, dynamic>))
          .toList();
      await Future<void>.delayed(const Duration(seconds: 5));
    }
  }

  @override
  Future<void> cancelOrder({required String idOrdenPedido}) async {
    final version = _versions[idOrdenPedido];
    if (version == null) {
      throw ApiException('Recargue el pedido para cancelarlo');
    }
    final response = await _api.request(
      'POST',
      '/customer/tenants/${ApiClient.tenantId}/orders/$idOrdenPedido/cancel',
      body: {
        'expectedVersion': version,
        'commandId': const Uuid().v4(),
        'reason': 'Cancelado por el cliente',
      },
    ) as Map<String, dynamic>;
    _versions[idOrdenPedido] = response['version'] as int;
  }

  @override
  Future<void> deleteOrder({required String idOrdenPedido}) =>
      cancelOrder(idOrdenPedido: idOrdenPedido);

  @override
  Future<EstimatedTime> getEstimatedTime() async => EstimatedTime(
        numHoras: 0,
        numMinutos: 0,
        tiempoEstimado: 'Sigue el estado del pedido en tiempo real',
      );

  OrdenPedido _mapOrder(Map<String, dynamic> json) {
    final id = json['id'] as String;
    _versions[id] = json['version'] as int;
    final details = (json['items'] as List<dynamic>? ?? const []).map((raw) {
      final item = raw as Map<String, dynamic>;
      return DetallePedido(
        id: item['id'] as String,
        cantidadPlato: double.parse(item['quantity'] as String).round(),
        valorTotal: double.parse(item['totalAmount'] as String),
        plato: Plato(
          id: item['productId'] as String,
          nombre: item['name'] as String,
          descripcion: '',
          descripcionCorta: item['sku'] as String,
          precio: double.parse(item['unitPrice'] as String),
          disponibilidad: true,
          tiempoPreparacion: '',
          categoria: Categoria.empty(),
          platoUrl: '',
          popular: false,
          numCalorias: 0,
        ),
      );
    }).toList();
    final balance = double.parse(json['balanceDue'] as String);
    return OrdenPedido(
      id: id,
      cliente: _customers[id] ?? Cliente.empty(),
      fechaEmision: DateTime.tryParse(json['placedAt']?.toString() ?? '') ??
          DateTime.now(),
      estadoOrden: _legacyStatus(json['status'] as String),
      mesero: Mesero.empty(),
      costoTotalPedido: double.parse(json['totalAmount'] as String),
      numOrden: json['orderNumber'].toString(),
      observaciones: json['notes']?.toString() ?? '',
      numMesa: 0,
      detalles: details,
      statusPago: balance == 0,
    );
  }

  void _assertContext() {
    if (ApiClient.tenantId.isEmpty ||
        ApiClient.branchId.isEmpty ||
        ApiClient.tableId.isEmpty) {
      throw ApiException('TENANT_ID, BRANCH_ID y TABLE_ID son obligatorios');
    }
  }

  String _legacyStatus(String status) => switch (status) {
        'PLACED' => 'Pedido realizado',
        'CONFIRMED' => 'Pedido confirmado',
        'IN_PREPARATION' => 'Pedido en preparación',
        'READY' => 'Pedido listo',
        'COMPLETED' => 'Pedido completado',
        'CANCELLED' => 'Pedido cancelado',
        'REJECTED' => 'Pedido rechazado',
        _ => status,
      };
}
