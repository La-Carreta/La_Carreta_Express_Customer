import 'package:la_carreta_express_cs/infraestructure/repositories/detalle_orden_pedido_repository_imp.dart';
import 'package:la_carreta_express_cs/presentation/providers/providers.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

class AppProvider{
  static List<SingleChildWidget> getProvider(DetalleOrdenPedidoRepositoryImp detOrdRepository){
    List<SingleChildWidget> providers = [
      ChangeNotifierProvider<CategoriaOptionProvider>(create: (_) => CategoriaOptionProvider()),
      ChangeNotifierProvider<NumberPlatesInfoProvider>(create: (_) => NumberPlatesInfoProvider()),
      ChangeNotifierProvider<DetalleOrdenPedidoProvider>(
        lazy: false, 
        create: (_) => DetalleOrdenPedidoProvider(detOrdPedidoRepository: detOrdRepository)..getDetalleOrden()
      ),
    ];

    return providers;
  }
}