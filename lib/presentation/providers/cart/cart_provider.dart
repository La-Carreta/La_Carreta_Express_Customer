import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/carrito.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/presentation/providers/cart/cart_repository_provider.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Carrito>((ref){
  final fetchCarrito = ref.watch( cartRepositoryProvider ).getCarrito;
  final addItemCart = ref.watch( cartRepositoryProvider ).createDetallePedido;
  final emptyCart = ref.watch( cartRepositoryProvider ).deleteCart;

  return CartNotifier(getCarrito: fetchCarrito, addItem: addItemCart, emptyCart: emptyCart);
});

typedef CarritoCallBack = Future<Carrito> Function({required Cliente cliente});
typedef DetalleCallBack = Future<void> Function({String? idCarrito, required Cliente cliente, required DetallePedido detallePedido});
typedef EmptyCartCallBack = Future<void> Function({required String idCarrito});

class CartNotifier extends StateNotifier<Carrito>{
  final CarritoCallBack getCarrito;
  final DetalleCallBack addItem;
  final EmptyCartCallBack emptyCart;
  bool isLoading = false;

  CartNotifier({
    required this.getCarrito,
    required this.addItem,
    required this.emptyCart
  }):super(Carrito.empty());


  Future<void> loadCart(Cliente cliente) async{
    if(isLoading) return;
    isLoading = true;

    final Carrito carrito = await getCarrito(cliente: cliente);
    print("Carrito data");
    state = carrito;

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> addOrUpdateItemCart({String? idCarrito, required Cliente cliente, required DetallePedido item}) async{
    if(isLoading) return;
    isLoading = true;
    //Buscar si el pedido se encuentra en la lista
    final itemFound = state.detallesPedido.firstWhere((det) => det.id == item.id, orElse: ()=> DetallePedido.empty());
    if(itemFound.id == ""){
      print("Agregando item....");
      //TODO: OJO CON EL ID DEL CARRITO
      await addItem(cliente: cliente, detallePedido: item);

      //TODO: Revisar como manejar el estado
//      state = [...state, item];

    }

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }


  Future<void> deleteCart(String idCarrito) async{
    if(isLoading) return;
    isLoading = true;

    await emptyCart(idCarrito: idCarrito);

    print("Carrito vacio");

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}

