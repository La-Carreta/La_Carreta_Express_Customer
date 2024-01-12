import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/infraestructure/models/plato_model.dart';

class PlatoMapper{
  static Plato platoToEntity(PlatoModel platoModel) => Plato(
    id: platoModel.id,
    nombre: platoModel.nombre, 
    descripcion: platoModel.descripcion, 
    descripcionCorta: platoModel.descripcionCorta, 
    precio: platoModel.precio, 
    disponibilidad: platoModel.disponibilidad, 
    numCalorias: platoModel.numCalorias,
    tiempoPreparacion: platoModel.tiempoPreparacion == null ? "" : platoModel.tiempoPreparacion!, 
    categoria: platoModel.categoria.nombre, 
    platoUrl: platoModel.imgUrl,
    popular: platoModel.popular    
  );
}