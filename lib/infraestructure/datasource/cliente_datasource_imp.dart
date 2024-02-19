import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_carreta_express_cs/domain/datasource/cliente_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/cliente_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/cliente_model.dart';

class ClienteDataSourceImpl extends ClienteDataSource{

  final firebase = FirebaseFirestore.instance;

  @override
  Future<Cliente> getCustomer({required String idCliente}) async{
    try {
      final doc = await firebase.collection('clientes').doc(idCliente).get();
      if(doc.exists){
        final data = doc.data();
        final Cliente cliente = ClienteMapper.clienteToEntity(ClienteModel.fromJson(doc.id, data!));
        return cliente;
      }
      throw Exception("Cliente no encontrado");      
    } catch (e) {
      throw Exception("Error al consultar el cliente: ${e.toString()}");
    }
  }

  @override
  Future<Cliente> updateCustomer({required Cliente cliente}) async{
    try {
      //TODO: Revisar este codigo
      final data = ClienteMapper.clienteToModel(cliente);
      await firebase.collection('clientes').doc(cliente.id).update(data.toJson());
      return cliente;
    } catch (e) {
      throw Exception("Error al actualizar el cliente: ${e.toString()}");
    }
  }
}