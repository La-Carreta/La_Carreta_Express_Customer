import 'package:la_carreta_express_cs/domain/entities/cliente.dart';

abstract class ClienteDataSource {
  Future<Cliente> getCustomer({required String idCliente});
  Future<Cliente> updateCustomer({required Cliente cliente});
}