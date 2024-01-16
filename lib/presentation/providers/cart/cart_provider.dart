import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_pedido.dart';
import 'package:la_carreta_express_cs/presentation/providers/cart/cart_repository_provider.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<DetallePedido>>((ref){
  final fetchDetails = ref.watch( cartRepositoryProvider ).getCarrito;
  final addItemCart = ref.watch( cartRepositoryProvider ).createDetallePedido;

  return CartNotifier(getDetalles: fetchDetails, addItem: addItemCart);
});

typedef DetallesCallBack = Future<List<DetallePedido>> Function();
typedef DetalleCallBack = Future<void> Function(DetallePedido item);

class CartNotifier extends StateNotifier<List<DetallePedido>>{
  final DetallesCallBack getDetalles;
  final DetalleCallBack addItem;

  bool isLoading = false;

  CartNotifier({
    required this.getDetalles,
    required this.addItem
  }):super([]);


  Future<void> loadCart() async{
    if(isLoading) return;
    isLoading = true;

    final List<DetallePedido> carrito = await getDetalles();
    state = [...carrito];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> addItemCart(DetallePedido item) async{
    //Buscar si el pedido se encuentra en la lista
    final itemFound = state.firstWhere((det) => det.id == item.id, orElse: ()=> DetallePedido.empty());
    if(itemFound.id == ""){
      print(item.plato.nombre);
      print("Agregando item....");
      await addItem(item);
      state = [...state, item];
    }
  }
}

