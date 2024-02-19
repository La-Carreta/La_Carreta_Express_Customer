import 'package:la_carreta_express_cs/domain/entities/cliente.dart';

abstract class ClienteRepository {
  Future<Cliente> getCustomer({required String idCliente});
  Future<Cliente> updateCustomer({required Cliente cliente});
}