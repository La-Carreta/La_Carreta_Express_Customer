import 'package:flutter/material.dart';

Color getColorByState(String state){
  switch(state){
    case "Pedido Realizado":
      return Colors.amber;
    case "Pedido Confirmado":
      return const Color(0xff83c5be);
    case "Pedido En Cola":
      return const Color(0xffadc178);
    case "Pedido En Proceso":
      return const Color(0xff006d77);
    case "Pedido Listo":
      return const Color(0xff3a0ca3);
    default:
      return const Color(0xffef233c);
  }
}