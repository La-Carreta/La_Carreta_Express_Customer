import 'dart:math';
import 'package:la_carreta_express_cs/domain/entities/estimated_time.dart';

String calculateEstimatedTime(EstimatedTime estimatedTime){
  final random = Random();
  //Tiempo aleatorio entre 10 - 15 y 20 minutos
  final numerosPermitidos = [10, 15, 20];

  final int minutos = numerosPermitidos[random.nextInt(numerosPermitidos.length)];

  final int minutosTotales = estimatedTime.numMinutos + minutos;
  final int horas = estimatedTime.numHoras + (minutosTotales ~/ 60);
  final int minutosRestantes = minutosTotales % 60;

  if(horas == 0) return "$minutosRestantes minutos";
  if(horas == 1) return "$horas hora y $minutosRestantes minutos";
  
  return "$horas horas y $minutosRestantes minutos";
}