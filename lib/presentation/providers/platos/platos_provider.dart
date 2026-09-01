import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/presentation/providers/platos/platos_repository_provider.dart';

final platosByCategoriaProvider =
    StateNotifierProvider<PlatosByCategoriaNotifier, List<Plato>>((ref) {
  final fetchPlatosByCategoria =
      ref.watch(platoRepositoryProvider).getPlatosByCategoria;
  return PlatosByCategoriaNotifier(
      fetchPlatosByCategoria: fetchPlatosByCategoria);
});

final platosProvider =
    StateNotifierProvider<PlatosNotifier, List<Plato>>((ref) {
  final fetchPlatos = ref.watch(platoRepositoryProvider).getPlatos;

  return PlatosNotifier(fetchPlatos: fetchPlatos);
});

typedef PlatoCallBack = Future<List<Plato>> Function();
typedef PlatoCallBackByCategoria = Future<List<Plato>> Function(String);

class PlatosNotifier extends StateNotifier<List<Plato>> {
  PlatoCallBack fetchPlatos;
  bool isLoading = false;

  PlatosNotifier({
    required this.fetchPlatos,
  }) : super([]) {
    loadPlatos();
  }

  Future<void> loadPlatos() async {
    if (isLoading) return;
    isLoading = true;

    final List<Plato> platos = await fetchPlatos();
    state = [...platos];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}

class PlatosByCategoriaNotifier extends StateNotifier<List<Plato>> {
  PlatoCallBackByCategoria fetchPlatosByCategoria;
  bool isLoading = false;

  PlatosByCategoriaNotifier({
    required this.fetchPlatosByCategoria,
  }) : super([]);

  Future<void> loadPlatosByCategoria(String categoria) async {
    if (isLoading) return;
    isLoading = true;

    final List<Plato> platos = await fetchPlatosByCategoria(categoria);
    state = [...platos];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> cleanData() async {
    state = [];
  }
}
