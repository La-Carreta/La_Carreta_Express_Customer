import 'package:la_carreta_express_cs/domain/datasource/carrito_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';

class CarritoDatasourceImp extends CarritoDatasource{

  bool isLoading = true;

  // Future<Isar> openDB() async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   if (Isar.instanceNames.isEmpty) {
  //     return await Isar.open([WirelessDataSchema], directory: dir.path);
  //   }

  //   return Future.value(Isar.getInstance());
  // }

  @override
  Future<void> deleteDetallePedido(String idDetalle) {
    // TODO: implement deleteDetallePedido
    throw UnimplementedError();
  }

  @override
  Future<List<DetallePedido>> getCarrito() {
    // TODO: implement getCarrito
    throw UnimplementedError();
  }

  @override
  Future<void> updateDetallePedido(String idDetalle, int cantidad) {
    // TODO: implement updateDetallePedido
    throw UnimplementedError();
  }

}