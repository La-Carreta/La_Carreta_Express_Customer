import 'package:flutter/material.dart';

Color getColorByState(String state) {
  switch (state) {
    case "Pedido realizado":
      return Colors.amber;
    case "Pedido confirmado":
      return const Color(0xff83c5be);
    case "Pedido en cola":
      return const Color(0xffadc178);
    case "Pedido en preparación":
      return const Color(0xff006d77);
    case "Pedido listo":
      return const Color(0xff3a0ca3);
    default:
      return const Color(0xffef233c);
  }
}
