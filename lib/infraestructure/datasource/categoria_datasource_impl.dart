import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:la_carreta_express_cs/domain/datasource/categorias_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/categoria_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/categoria_model.dart';

class CategoriaDatasourceImpl extends CategoriasDatasource{

  final firebase = FirebaseFirestore.instance;

  @override
  Future<List<Categoria>> getCategorias() async{
      try {
        final CollectionReference collectionReference = firebase.collection("categorias");
        final QuerySnapshot response = await collectionReference.orderBy("nombre", descending: true).get();

        if(response.docs.isNotEmpty){
          final categoriaResponseList = response.docs.map((cat) => CategoriaModel.fromJson(cat.id,cat.data() as Map<String, dynamic>)).toList();        
          final List<Categoria> categorias = categoriaResponseList.map(
            (cat) => CategoriaMapper.categoriaToEntity(cat),
          ).toList();

          return categorias;
        }
        return [];
      } catch (e) {
        debugPrint("Error al consultar las categorias: ${e.toString()}");
        return [];
      }
  }  
}