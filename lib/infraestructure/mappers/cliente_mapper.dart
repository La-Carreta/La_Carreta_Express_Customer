import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/infraestructure/models/cliente_model.dart';

class ClienteMapper{

  static ClienteModel clienteToModel(Cliente cliente) => ClienteModel(
    id: cliente.id,
    nombre: cliente.nombre, 
    apellido: cliente.apellido, 
    celular: cliente.celular, 
    direccion: cliente.direccion, 
    email: cliente.correo, 
    imgUrl: cliente.imgUrl, 
    uuid: cliente.uuid
  );

  static ClienteModel clienteToModelRegister(Cliente cliente) => ClienteModel(
    nombre: cliente.nombre, 
    apellido: cliente.apellido, 
    celular: cliente.celular, 
    direccion: cliente.direccion, 
    email: cliente.correo, 
    imgUrl: cliente.imgUrl, 
    uuid: cliente.uuid
  );

  static Cliente clienteToEntity(ClienteModel cliente) => Cliente(
    id: cliente.id,
    nombre: cliente.nombre, 
    apellido: cliente.apellido, 
    celular: cliente.celular, 
    direccion: cliente.direccion, 
    correo: cliente.email, 
    imgUrl: cliente.imgUrl, 
    uuid: cliente.uuid
  );

}