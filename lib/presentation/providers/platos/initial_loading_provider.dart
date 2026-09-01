import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/presentation/providers/categoria/categorias_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/platos/platos_provider.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(categoriasProvider).isEmpty;
  final step2 = ref.watch(platosProvider).isEmpty;

  if (step1 || step2) return true;

  return false; //Terminamos de cargar
});

final initialLoadingPlatosProvider = Provider<bool>((ref) {
  final step3 = ref.watch(platosByCategoriaProvider).isEmpty;
  if (step3) return true;

  return false; //Terminamos de cargar
});
