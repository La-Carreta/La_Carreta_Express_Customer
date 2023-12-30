import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/domain/entities/detalle_orden_pedido.dart';
import 'package:la_carreta_express_cs/domain/respositories/detalle_orden_pedido_repository.dart';

class DetalleOrdenPedidoProvider extends ChangeNotifier{
  final DetalleOrdenPedidoRepository detOrdPedidoRepository;

  bool initialLoading = true;
  List<DetalleOrdenPedido> detallesPedido = [];

  DetalleOrdenPedidoProvider({required this.detOrdPedidoRepository});

  //Database
  Future<void> getDetalleOrden() async{
    final newDetailsOrder = await detOrdPedidoRepository.getDetallesCarrito();
    detallesPedido.addAll(newDetailsOrder);
    initialLoading = false;
    notifyListeners();
  }

  //Local
  Future<void> updateDetalleOrden(int id, int cantidad) async{
    final newDetailOrder = await detOrdPedidoRepository.updateDetalleCarritoById(id, cantidad);
    final index = detallesPedido.indexWhere((detalle) => detalle.id == id);  
    if (index != -1) {
      detallesPedido[index] = newDetailOrder;
      notifyListeners();
    }
  }
}