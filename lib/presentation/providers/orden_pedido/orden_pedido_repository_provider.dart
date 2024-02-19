import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/infraestructure/datasource/orden_pedido_datasource_impl.dart';
import 'package:la_carreta_express_cs/infraestructure/repositories/orden_pedido_repository_imp.dart';

final ordenPedidoRepositoryProvider = Provider((ref) => OrdenPedidoRepositoryImp(OrdenPedidoDatasourceImpl()));