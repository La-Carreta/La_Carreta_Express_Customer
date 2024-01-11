import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'package:la_carreta_express_cs/presentation/providers/categoria/categorias_repository_provider.dart';


final categoriaSeleccionadaProvider = StateProvider((ref) => 0);

final categoriaProvider = Provider((ref){
  final fetchCategorias = ref.watch( categoriasProvider );
  if(fetchCategorias.isEmpty) return "";
  return fetchCategorias[0].nombre;
});

final categoriasProvider = StateNotifierProvider<CategoriasNotifier, List<Categoria>>((ref){
  final fetchCategorias = ref.watch( categoriaRepositoryProvider ).getCategorias;

  return CategoriasNotifier(fetchCategorias: fetchCategorias);
});

typedef CategoriaCallBack = Future<List<Categoria>> Function();

class CategoriasNotifier extends StateNotifier<List<Categoria>> {
  CategoriaCallBack fetchCategorias;

  CategoriasNotifier({
    required this.fetchCategorias
  }):super([]){
    loadCategorias();
  }

  Future<void> loadCategorias() async{
    final List<Categoria> categorias = await fetchCategorias();
    state = [...categorias];
  }

}

