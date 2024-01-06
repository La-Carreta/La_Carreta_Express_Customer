import 'package:la_carreta_express_cs/domain/entities/plato.dart';

abstract class PlatosDatasource{
  Future<List<Plato>> getPlatos();
  Future<List<Plato>> getPlatosByCategoria(String categoria);
}