import 'package:hive/hive.dart';
import 'package:la_carreta_express_cs/domain/datasource/carrito_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';

class CarritoDatasourceImp extends CarritoDatasource{

  final _cartBox = Hive.box<DetallePedido>('cart');

  @override
  Future<void> deleteDetallePedido(String idDetalle) {
    // TODO: implement deleteDetallePedido
    throw UnimplementedError();
  }

  @override
  Future<List<DetallePedido>> getCarrito() async{
    try {
      final resp = _cartBox.toMap();
      print("Tam del carrito");
      print(resp.length);
      return [];
    } catch (e) {
      throw Exception("Error al consultar el carrito");
    }
  }

  @override
  Future<void> updateDetallePedido(String idDetalle, int cantidad) {
    // TODO: implement updateDetallePedido
    throw UnimplementedError();
  }
  
  @override
  Future<void> createDetallePedido(DetallePedido detallePedido) async {
    try {
      _cartBox.add(detallePedido);
      print("Cart lenght ${_cartBox.length}");
    } catch (e) {
      throw Exception("Error al cargar plato en el carrito");      
    }
  }

}