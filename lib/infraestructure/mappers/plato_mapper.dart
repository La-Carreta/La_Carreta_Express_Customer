import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/categoria_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/plato_model.dart';

class PlatoMapper {
  static Plato platoToEntity(PlatoModel platoModel) => Plato(
      id: platoModel.id,
      nombre: platoModel.nombre,
      descripcion: platoModel.descripcion,
      descripcionCorta: platoModel.descripcionCorta,
      precio: platoModel.precio,
      disponibilidad: platoModel.disponibilidad,
      numCalorias: platoModel.numCalorias,
      tiempoPreparacion: platoModel.tiempoPreparacion == null
          ? ""
          : platoModel.tiempoPreparacion!,
      categoria: CategoriaMapper.categoriaToEntity(platoModel.categoria),
      platoUrl: platoModel.imgUrl,
      popular: platoModel.popular);

  static PlatoModel platoToModel(Plato plato) => PlatoModel(
      id: plato.id,
      categoria: CategoriaMapper.categoriaToModel(plato.categoria),
      descripcion: plato.descripcion,
      descripcionCorta: plato.descripcionCorta,
      disponibilidad: plato.disponibilidad,
      imgUrl: plato.platoUrl,
      nombre: plato.nombre,
      numCalorias: plato.numCalorias,
      popular: plato.popular,
      precio: plato.precio,
      tiempoPreparacion: plato.tiempoPreparacion);
}
