import 'package:la_carreta_express_cs/domain/entities/mesero.dart';
import 'package:la_carreta_express_cs/infraestructure/models/empleado_model.dart';

class MeseroMapper{
  static EmpleadoModel empleadoToModel(Mesero mesero) => EmpleadoModel(
    id: mesero.id,
    nombre: mesero.nombre, 
    apellido: mesero.apellido, 
    celular: mesero.celular, 
    email: mesero.email, 
    imgUrl: mesero.imgUrl, 
    uuid: mesero.uuid, 
    estado: mesero.estado,
    areaTrabajo: mesero.areaTrabajo,
    fechaContratacion: mesero.fechaContratacion    
  );

  static Mesero empleadoToEntity(EmpleadoModel mesero) => Mesero(
    id: mesero.id,
    nombre: mesero.nombre, 
    apellido: mesero.apellido, 
    celular: mesero.celular, 
    email: mesero.email, 
    imgUrl: mesero.imgUrl, 
    uuid: mesero.uuid, 
    estado: mesero.estado,
    areaTrabajo: mesero.areaTrabajo,
    fechaContratacion: mesero.fechaContratacion    
  );

}