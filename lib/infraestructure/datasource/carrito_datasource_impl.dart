import 'package:la_carreta_express_cs/domain/datasource/carrito_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/carrito.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:uuid/uuid.dart';

class CarritoDatasourceImpl extends CarritoDatasource {
  static Carrito? _cart;

  @override
  Future<Carrito> getCarritoByIdCliente({required String idCliente}) async =>
      _cart ?? Carrito.empty();

  @override
  Future<Carrito> getCarritoById({required String idCarrito}) async =>
      _cart?.id == idCarrito ? _cart! : Carrito.empty();

  @override
  Future<Carrito> createOrUpdateDetallePedido({
    String? idCarrito,
    required Cliente cliente,
    required DetallePedido detallePedido,
  }) async {
    final current = _cart ??
        Carrito(
          id: const Uuid().v4(),
          detallesPedido: const [],
          cliente: cliente,
          total: 0,
        );
    final details = [...current.detallesPedido];
    final index = details.indexWhere(
      (item) => item.plato.id == detallePedido.plato.id,
    );
    if (index >= 0) {
      final quantity =
          details[index].cantidadPlato + detallePedido.cantidadPlato;
      details[index] = DetallePedido.copyWith(
        id: details[index].id,
        plato: details[index].plato,
        cantidadPlato: quantity,
        valorTotal: quantity * details[index].plato.precio,
      );
    } else {
      details.add(DetallePedido.copyWith(
        id: detallePedido.id.isEmpty ? const Uuid().v4() : detallePedido.id,
        plato: detallePedido.plato,
        cantidadPlato: detallePedido.cantidadPlato,
        valorTotal: detallePedido.valorTotal,
      ));
    }
    return _replace(current, details);
  }

  @override
  Future<Carrito> updateDetallePedido({
    required Carrito carrito,
    required String idDetalle,
    required int cantidad,
  }) async {
    final details = carrito.detallesPedido.map((item) {
      if (item.id != idDetalle) return item;
      return DetallePedido.copyWith(
        id: item.id,
        plato: item.plato,
        cantidadPlato: cantidad,
        valorTotal: cantidad * item.plato.precio,
      );
    }).toList();
    return _replace(carrito, details);
  }

  @override
  Future<Carrito> deleteDetallePedido({
    required String idCarrito,
    required String idDetalle,
    required Carrito cart,
  }) async =>
      _replace(
        cart,
        cart.detallesPedido.where((item) => item.id != idDetalle).toList(),
      );

  @override
  Future<void> deleteCart({
    required String idCarrito,
    required Carrito cart,
  }) async {
    _cart = Carrito(
      id: cart.id,
      cliente: cart.cliente,
      detallesPedido: const [],
      total: 0,
    );
  }

  Carrito _replace(Carrito current, List<DetallePedido> details) {
    details.sort((a, b) => a.plato.nombre.compareTo(b.plato.nombre));
    _cart = Carrito(
      id: current.id,
      cliente: current.cliente,
      detallesPedido: details,
      total: details.fold(0, (total, item) => total + item.valorTotal),
    );
    return _cart!;
  }
}
