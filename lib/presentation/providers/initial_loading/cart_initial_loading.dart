import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/presentation/providers/providers.dart';

final cartInitialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(cartProvider).id.isEmpty;
  final step2 = ref.watch(timeOrderProvider).tiempoEstimado.isEmpty;

  if (step1 || step2) return true;

  return false; //Terminamos de cargar
});
