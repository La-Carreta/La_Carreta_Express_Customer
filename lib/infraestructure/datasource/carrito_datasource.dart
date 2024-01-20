import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_carreta_express_cs/domain/datasource/carrito_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/carrito.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/carrito_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/carrito_model.dart';

class CarritoDatasourceImp extends CarritoDatasource{
  final firebase = FirebaseFirestore.instance;

  @override
  Future<void> deleteDetallePedido({required String idCarrito, required String idDetalle}) {
    // TODO: implement deleteDetallePedido
    throw UnimplementedError();
  }

  @override
  Future<Carrito> getCarrito({required Cliente cliente}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("cart");
      final QuerySnapshot response = await collectionReference
        .where("cliente.id", isEqualTo: cliente.id)
        .get();

      if(response.docs.isNotEmpty){
        final carritoResponseList = response.docs.map((cart) => CarritoModel.fromJson(cart.id, cart.data() as Map<String, dynamic>)).toList();        
        final List<Carrito> cart = carritoResponseList.map(
          (cart) => CarritoMapper.carritoToEntity(cart),
        ).toList();

        print("Si hay datos, ${cart.length}");
        return cart[0];
      }

      return Carrito.empty();
    } catch (e) {
      throw Exception("Error al cargar carrito..., ${e.toString()}");            
    }
  }

  @override
  Future<void> updateDetallePedido({required String idCarrito, required String idDetalle, required int cantidad}) {
    // TODO: implement updateDetallePedido
    throw UnimplementedError();
  }
  
  @override
  Future<void> createDetallePedido({String? idCarrito, required Cliente cliente, required DetallePedido detallePedido}) async{
    try {      
      CollectionReference collectionReference = firebase.collection('cart');
      //Consultar a la base de datos si existe el carrito..            

      //** No existe el carrito
      // final DetallePedidoModel item = DetallePedidoMapper.detallePedidoToModel(detallePedido);
      // final data = item.toJson(); 
      List<DetallePedido> detalles = [];
      detalles.add(detallePedido);

      final CarritoModel carritoData = CarritoMapper.carritoToModel(Carrito(detallesPedido: detalles, cliente: cliente));       
      await collectionReference.add(carritoData.toJson());

    } catch (e) {
      throw Exception("Error al agregar item..., ${e.toString()}");      
    }
  }
  
  @override
  Future<void> deleteCart({required String idCarrito}) {
    // TODO: implement deleteCart
    throw UnimplementedError();
  }


}