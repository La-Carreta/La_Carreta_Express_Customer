import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/presentation/providers/providers.dart';

final platoInfoProvider = StateNotifierProvider<PlatoMapNotifier, Map<String, Plato>>((ref){
  final platoRepository = ref.watch(platoRepositoryProvider);

  return PlatoMapNotifier(
    getPlato: platoRepository.getPlatoById
  );

});

typedef GetPlatoCallBack = Future<Plato> Function(String movieId);

class PlatoMapNotifier extends StateNotifier<Map<String, Plato>>{

  final GetPlatoCallBack getPlato;

  PlatoMapNotifier({required this.getPlato}):super({});
  
  Future<void> loadPlato(String platoId) async{
    if( state[platoId] != null) return;
    final plato = await getPlato(platoId);
    state = {...state, platoId: plato};    
  }
}