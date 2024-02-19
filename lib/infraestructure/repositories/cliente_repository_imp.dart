
import 'package:la_carreta_express_cs/domain/datasource/cliente_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/domain/repositories/cliente_repository.dart';

class ClienteRepositoryImp implements ClienteRepository {
  final ClienteDataSource datasource;

  ClienteRepositoryImp(this.datasource);

  @override
  Future<Cliente> getCustomer({required String idCliente}) {
    return datasource.getCustomer(idCliente: idCliente);
  }

  @override
  Future<Cliente> updateCustomer({required Cliente cliente}) {
    return datasource.updateCustomer(cliente: cliente);
  }

}
