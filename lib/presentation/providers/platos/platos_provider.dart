

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/presentation/providers/platos/platos_repository_provider.dart';

final platosProvider = StateNotifierProvider<PlatosNotifier, List<Plato>>((ref){
  final fetchPlatos = ref.watch( platoRepositoryProvider ).getPlatos;
  final fetchPlatosByCategoria = ref.watch( platoRepositoryProvider ).getPlatosByCategoria;

  return PlatosNotifier(fetchPlatos: fetchPlatos, fetchPlatosByCategoria: fetchPlatosByCategoria);
});

typedef PlatoCallBack = Future<List<Plato>> Function();
typedef PlatoCallBackParameter = Future<List<Plato>> Function(String);

class PlatosNotifier extends StateNotifier<List<Plato>>{

  PlatoCallBack fetchPlatos;
  PlatoCallBackParameter fetchPlatosByCategoria;

  PlatosNotifier({
    required this.fetchPlatos,
    required this.fetchPlatosByCategoria
  }):super([]){
    loadPlatos();
  }

  Future<void> loadPlatos() async{
    final List<Plato> platos = await fetchPlatos();
    state = [...platos];
  }

  Future<void> loadPlatosByCategoria(String categoria) async {
    final List<Plato> platos = await fetchPlatosByCategoria(categoria);
    state = [...platos];
  }

}