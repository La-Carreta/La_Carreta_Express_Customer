import 'dart:math';

String generateOrderNumber() {
  final Random random = Random();
  String codigo = '';

  for (int i = 0; i < 8; i++) {
    codigo += random.nextInt(10).toString();
  }

  return codigo;
}
