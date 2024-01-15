import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterPlatoProvider = StateNotifierProvider<CounterPlatoNotifier, Map<String, int>>((ref){
  return CounterPlatoNotifier();
});

class CounterPlatoNotifier extends StateNotifier<Map<String, int>>{
  CounterPlatoNotifier():super({});

  Future<void> loadQuantityPlato(String platoId, int quantity) async{
    if(state[platoId] != null ) return;
    await Future.delayed(const Duration(milliseconds: 300), (){
      state = {...state, platoId: quantity};    
      print("Cargado cantidades de los platos en Cache");
    });
  }

  Future<void> increaseQuantityPlato(String platoId, int quantity) async{
    if( state[platoId] == null ) return;

    int cantidad = state[platoId]!;
    cantidad += quantity;
    //Actualizar cantidad en base al id del plato
    state = {...state, platoId: cantidad};
    print("Actualizando las cantidades de los platos en Cache");

  }

  Future<void> decreaseQuantityPlato(String platoId, int quantity) async{
    if( state[platoId] == null ) return;

    int cantidad = state[platoId]!;
    if(cantidad <= 1) return; 
    cantidad -= quantity;
    //Actualizar cantidad en base al id del plato
    state = {...state, platoId: cantidad};
  }

}

