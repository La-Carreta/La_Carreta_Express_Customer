import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_carreta_express_cs/domain/datasource/carrito_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/carrito.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/carrito_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/carrito_model.dart';

class CarritoDatasourceImpl extends CarritoDatasource{
  final firebase = FirebaseFirestore.instance;

  @override
  Future<Carrito> deleteDetallePedido({required String idCarrito, required String idDetalle, required Carrito cart}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("cart");
      final newDetailsCart = cart.detallesPedido.where((item) => item.id != idDetalle).toList();
      newDetailsCart.sort((a, b) => a.plato.nombre.compareTo(b.plato.nombre));
      double totalUpdated = 0.0;
      for (DetallePedido item in newDetailsCart) { 
        totalUpdated += item.valorTotal;
      } 

      //* Actualizar carrito  
      await updateCart(collectionReference, cart, newDetailsCart, totalUpdated);

      return Carrito(
        id: cart.id,
        cliente: cart.cliente,
        detallesPedido: newDetailsCart, 
        total: totalUpdated,        
      );
    } catch (e) {
      throw Exception("Error al eliminar item del carrito..., ${e.toString()}");                  
    }
  }

  @override
  Future<Carrito> getCarritoByIdCliente({required String idCliente}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("cart");
      final QuerySnapshot response = await collectionReference
        .where("cliente.uuid", isEqualTo: idCliente)
        .get();

      if(response.docs.isNotEmpty){
        final carritoResponseList = response.docs.map((cart) => CarritoModel.fromJson(cart.id, cart.data() as Map<String, dynamic>)).toList();        
        final List<Carrito> cart = carritoResponseList.map(
          (cart) => CarritoMapper.carritoToEntity(cart),
        ).toList();

       cart[0].detallesPedido.sort((a, b) => a.plato.nombre.compareTo(b.plato.nombre));

        return cart[0];
      }

      return Carrito.empty();
    } catch (e) {
      throw Exception("Error al cargar carrito..., ${e.toString()}");            
    }
  }

  @override
  Future<Carrito> updateDetallePedido({required Carrito carrito, required String idDetalle, required int cantidad}) async{
    try {
      //** 1. Consultar el detalle en el carrito por su id 
      CollectionReference collectionReference = firebase.collection('cart');
      final detalleToUpdate = carrito.detallesPedido.firstWhere((item) => item.id == idDetalle, orElse: DetallePedido.empty);
      final valorTotalActualizado = detalleToUpdate.plato.precio * cantidad;

      final detalleUpdated = DetallePedido.copyWith(
        id: detalleToUpdate.id,
        cantidadPlato: cantidad,
        plato: detalleToUpdate.plato,
        valorTotal: valorTotalActualizado
      );

      List<DetallePedido> newDetailsCart = carrito.detallesPedido.where((item) => item.id != idDetalle).toList();
      newDetailsCart.add(detalleUpdated);
      newDetailsCart.sort((a, b) => a.plato.nombre.compareTo(b.plato.nombre));
      
      double totalUpdated = 0.0;

      for (DetallePedido item in newDetailsCart) { 
        totalUpdated += item.valorTotal;
      } 

      //* Actualizar carrito  
      await updateCart(collectionReference, carrito, newDetailsCart, totalUpdated);

      return Carrito(
        id: carrito.id,
        cliente: carrito.cliente,
        detallesPedido: newDetailsCart, 
        total: totalUpdated,        
      );

    } catch (e) {
      throw Exception("Error al actualizar el item con el id del detalle: $idDetalle..., ${e.toString()}");            
    }
  }
  
  @override
  Future<void> createOrUpdateDetallePedido({String? idCarrito, required Cliente cliente, required DetallePedido detallePedido}) async{
    try {      
      //** 1. Consultar si el cliente tiene un carrito creado anteriormente. 
      final carritoFs = await getCarritoByIdCliente(idCliente: cliente.id);

      CollectionReference collectionReference = firebase.collection('cart');
      List<DetallePedido> detalles = [];
      double totalUpdated = 0.0;

      //** No existe el carrito
      if( carritoFs.id.isEmpty ){
        detalles.add(detallePedido);
        detalles.sort((a, b) => a.plato.nombre.compareTo(b.plato.nombre));

        final CarritoModel carritoData = CarritoMapper.carritoToModel(Carrito(detallesPedido: detalles, cliente: cliente, total: detalles[0].valorTotal));       
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
          newDetailsCart.sort((a, b) => a.plato.nombre.compareTo(b.plato.nombre));

          for (DetallePedido item in newDetailsCart) { 
            totalUpdated += item.valorTotal;
          } 

          //* Actualizar carrito
          await updateCart(collectionReference, carritoFs, newDetailsCart, totalUpdated);
        }
        //* Se crea el detalle del pedido en la orden
        else{
          List<DetallePedido> newDetailsCart = carritoFs.detallesPedido.map((item) => item).toList();
          newDetailsCart.add(detallePedido);
          newDetailsCart.sort((a, b) => a.plato.nombre.compareTo(b.plato.nombre));

          for (DetallePedido item in newDetailsCart) { 
            totalUpdated += item.valorTotal;
          } 

          //* Actualizar carrito
          await updateCart(collectionReference, carritoFs, newDetailsCart, totalUpdated);          
        }
      }
    } catch (e) {
      throw Exception("Error al agregar item..., ${e.toString()}");      
    }
  }
  
  @override
  Future<void> deleteCart({required String idCarrito, required Carrito cart}) async{
    try {
      final emptyCart = Carrito(
        id: cart.id,
        cliente: cart.cliente,
        detallesPedido: [],
        total: 0.0
      );

      final emptyCartModel = CarritoMapper.carritoToModel(emptyCart);

      final CollectionReference collectionReference = firebase.collection("cart");
      await collectionReference.doc(idCarrito).update(emptyCartModel.toJson());
    } catch (e) {
      throw Exception("Error al eliminar carrito..., ${e.toString()}");            
    }
  }

  Future<void> updateCart(CollectionReference collectionReference, Carrito carritoFs, List<DetallePedido> newDetailsCart, double totalUpdated) async{
    Carrito cartUpdated = Carrito(
      id: carritoFs.id,
      cliente: carritoFs.cliente,
      detallesPedido: newDetailsCart,
      total: totalUpdated
    );          

    final CarritoModel carritoData = CarritoMapper.carritoToModel(cartUpdated);       

    //* Enviar detalle actualizados.
    await collectionReference.doc(carritoFs.id).update(carritoData.toJson());          
  }
  
  @override
  Future<Carrito> getCarritoById({required String idCarrito}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("cart");
      final response = await collectionReference
        .doc(idCarrito)
        .get();

      if(response.exists){
        final carrito =  CarritoMapper.carritoToEntity(CarritoModel.fromJson(idCarrito, response.data() as Map<String, dynamic>));
        return carrito;
      }

      return Carrito.empty();
    } catch (e) {
      throw Exception("Error al cargar carrito..., ${e.toString()}");            
    }
  }
}