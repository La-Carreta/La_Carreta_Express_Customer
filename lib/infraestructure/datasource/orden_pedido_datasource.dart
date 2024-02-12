import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/domain/datasource/orden_pedido_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/orden_pedido_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/orden_pedido_model.dart';

class OrdenPedidoDatasourceImp extends OrdenPedidoDatasource{
  final firebase = FirebaseFirestore.instance;

  @override
  Future<void> createOrder({required OrdenPedido order}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("ordenPedido");
      final OrdenPedidoModel ordenPedidoData = OrdenPedidoMapper.ordenPedidoToModel(order);       

      await collectionReference.add(ordenPedidoData.toJson());

    } catch (e) {
      throw Exception("Error al crear la orden. ${e.toString()}");          
    }
  }

  @override
  Future<OrdenPedido> getOrderById({required String idOrdenPedido}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("ordenPedido");
      final response = await collectionReference
        .doc(idOrdenPedido)
        .get();

      if(response.exists){
        final OrdenPedidoModel ordenPedido = OrdenPedidoModel.fromJson(response.id, response.data() as Map<String, dynamic>);
        final OrdenPedido orden = OrdenPedidoMapper.ordenPedidoToEntity(ordenPedido);

        return orden;
      }

      return OrdenPedido.empty();
    } catch (e) {
      throw Exception("Error al cargar carrito..., ${e.toString()}");            
    }

 }

  @override
  Future<List<OrdenPedido>> getOrdersByCustomer({required String idCliente}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("ordenPedido");
      //Consultar las ordenes por fecha de forma ascendente
      final QuerySnapshot response = await collectionReference
        .where("cliente.id", isEqualTo: idCliente)
        .orderBy("fecha", descending: true)
        .get();

      if(response.docs.isNotEmpty){
        final ordersResponseList = response.docs.map((order) => OrdenPedidoModel.fromJson(order.id, order.data() as Map<String, dynamic>)).toList();        
        final List<OrdenPedido> ordenes = ordersResponseList.map(
          (order) => OrdenPedidoMapper.ordenPedidoToEntity(order),
        ).toList();

        return ordenes;
      }

      return [];
    } catch (e) {
      debugPrint("Error al cargar las ordenes ..., ${e.toString()}");
      throw Exception("Error al cargar las ordenes ..., ${e.toString()}");            
    }
  }
  
  @override
  Future<List<OrdenPedido>> getOrdersByFilter({required String idCliente, required String state}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("ordenPedido");
      final QuerySnapshot response = await collectionReference
        .where("cliente.id", isEqualTo: idCliente)
        .where("estado", isEqualTo: state)
        .orderBy("fecha", descending: true)
        .get();

      if(response.docs.isNotEmpty){
        final ordersResponseList = response.docs.map((order) => OrdenPedidoModel.fromJson(order.id, order.data() as Map<String, dynamic>)).toList();        
        final List<OrdenPedido> ordenes = ordersResponseList.map(
          (order) => OrdenPedidoMapper.ordenPedidoToEntity(order),
        ).toList();

        return ordenes;
      }

      return [];
    } catch (e) {
      debugPrint("Error al cargar las ordenes ..., ${e.toString()}");
      throw Exception("Error al cargar las ordenes ..., ${e.toString()}");            
    }
  }
}