import 'package:la_carreta_express_cs/domain/entities/cliente.dart';

String formatName(Cliente cliente) {
  return "${cliente.nombre} ${cliente.apellido}";
}

String formatUsername(Cliente cliente) {
  final email = cliente.correo;
  final index = email.indexOf("@");
  return "@${email.substring(0, index)}";
}