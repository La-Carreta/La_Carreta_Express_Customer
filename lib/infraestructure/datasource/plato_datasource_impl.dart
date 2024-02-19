import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/domain/datasource/platos_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/plato_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/plato_model.dart';

class PlatoDatasourceImpl extends PlatosDatasource{
  final firebase = FirebaseFirestore.instance;

  @override
  Future<List<Plato>> getPlatos() async{
    try {
      final CollectionReference collectionReference = firebase.collection("platos");
      final QuerySnapshot response = await collectionReference.orderBy("nombre", descending: true).get();

      if(response.docs.isNotEmpty){
        final platosResponseList = response.docs.map((plato) => PlatoModel.fromJson(plato.id, plato.data() as Map<String, dynamic>)).toList();        
        final List<Plato> platos = platosResponseList.map(
          (plato) => PlatoMapper.platoToEntity(plato),
        ).toList();

        return platos;
      }
      return [];
    } catch (e) {
      debugPrint("Error al consultar las categorias: ${e.toString()}");
      return [];
    }

  }

  @override
  Future<List<Plato>> getPlatosByCategoria(String categoria) async{
    try { 
      final CollectionReference collectionReference = firebase.collection("platos");
      final QuerySnapshot response = await collectionReference
        .where("categoria.nombre", isEqualTo: categoria)
        .orderBy("nombre", descending: true).get();

      if(response.docs.isNotEmpty){
        final platosResponseList = response.docs.map((plato) => PlatoModel.fromJson(plato.id, plato.data() as Map<String, dynamic>)).toList();        
        final List<Plato> platos = platosResponseList.map(
          (plato) => PlatoMapper.platoToEntity(plato),
        ).toList();

        return platos;
      }
      return [];
    } catch (e) {
       debugPrint("Error al consultar las categorias por categoria: ${e.toString()}");
      return [];     
    }
  }
  
  @override
  Future<Plato> getPlatoById(String id) async{
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await firebase.collection("platos").doc(id).get();
      if(doc.exists){
        final data = doc.data();
        final Plato plato = PlatoMapper.platoToEntity(PlatoModel.fromJson(doc.id, data!));
        return plato;
      } 
      throw Exception("Error al consultar el plato con id $id");    
    } catch (e) {
      throw Exception("Error al consultar el plato con id $id");    
    }
  }

}