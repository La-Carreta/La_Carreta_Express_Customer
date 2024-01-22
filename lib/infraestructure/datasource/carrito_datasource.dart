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
  Future<Carrito> getCarrito({required String idCliente}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("cart");
      final QuerySnapshot response = await collectionReference
        .where("cliente.id", isEqualTo: idCliente)
        .get();

      if(response.docs.isNotEmpty){
        final carritoResponseList = response.docs.map((cart) => CarritoModel.fromJson(cart.id, cart.data() as Map<String, dynamic>)).toList();        
        final List<Carrito> cart = carritoResponseList.map(
          (cart) => CarritoMapper.carritoToEntity(cart),
        ).toList();

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
  Future<void> createOrUpdateDetallePedido({String? idCarrito, required Cliente cliente, required DetallePedido detallePedido}) async{
    try {      
      //** 1. Consultar si el cliente tiene un carrito creado anteriormente. 
      final carritoFs = await getCarrito(idCliente: cliente.id);

      CollectionReference collectionReference = firebase.collection('cart');
      List<DetallePedido> detalles = [];
      //** No existe el carrito
      if( carritoFs.id.isEmpty ){
        detalles.add(detallePedido);
        final CarritoModel carritoData = CarritoMapper.carritoToModel(Carrito(detallesPedido: detalles, cliente: cliente));       
        await collectionReference.add(carritoData.toJson());
      }
      //** Insertar o actualizar el detalle del carrito
      else{
        //* Buscar si el plato existe en el listado de detalles del carrito
        final detallesExistente = carritoFs.detallesPedido.where((item) => item.plato.id == detallePedido.plato.id).toList();
        if(detallesExistente.isNotEmpty){
          final cantidadActualizada = detallesExistente[0].cantidadPlato + detallePedido.cantidadPlato;
          final valorTotalActualizado = cantidadActualizada * detallePedido.plato.precio;

          //* Actualizar cantidad del plato.          
          DetallePedido detalle = DetallePedido.copyWith(
            id: detallesExistente[0].id,
            plato: detallesExistente[0].plato,
            cantidadPlato: cantidadActualizada,
            valorTotal: valorTotalActualizado
          );

          List<DetallePedido> newDetailsCart = carritoFs.detallesPedido.where((item) => item.plato.id != detallePedido.plato.id).toList();
          newDetailsCart.add(detalle);

          //* Actualizar carrito
          await updateCart(collectionReference, carritoFs, newDetailsCart);
        }
        //* Se crea el detalle del pedido en la orden
        else{
          List<DetallePedido> newDetailsCart = carritoFs.detallesPedido.map((item) => item).toList();
          newDetailsCart.add(detallePedido);

          //* Actualizar carrito
          await updateCart(collectionReference, carritoFs, newDetailsCart);          
        }
      }
    } catch (e) {
      throw Exception("Error al agregar item..., ${e.toString()}");      
    }
  }
  
  @override
  Future<void> deleteCart({required String idCarrito}) {
    // TODO: implement deleteCart
    throw UnimplementedError();
  }


  Future<void> updateCart(CollectionReference collectionReference, Carrito carritoFs, List<DetallePedido> newDetailsCart) async{
    Carrito cartUpdated = Carrito.copyWith(
      id: carritoFs.id,
      cliente: carritoFs.cliente,
      detallesPedido: newDetailsCart
    );          

    final CarritoModel carritoData = CarritoMapper.carritoToModel(cartUpdated);       

    //* Enviar detalle actualizados.
    await collectionReference.doc(carritoFs.id).update(carritoData.toJson());          
  }
}