import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/infraestructure/datasource/carrito_datasource_impl.dart';
import 'package:la_carreta_express_cs/infraestructure/repositories/carrito_repository_imp.dart';

final cartRepositoryProvider =
    Provider((ref) => CarritoRepositoryImpl(CarritoDatasourceImpl()));
