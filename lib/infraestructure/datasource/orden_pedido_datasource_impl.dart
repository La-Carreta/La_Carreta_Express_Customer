import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/domain/datasource/orden_pedido_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/orden_pedido_mapper.dart';
import 'package:la_carreta_express_cs/infraestructure/models/orden_pedido_model.dart';

class OrdenPedidoDatasourceImpl extends OrdenPedidoDatasource{
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
  Stream<OrdenPedido> getOrderById({required String idOrdenPedido}) {
    try {
      final CollectionReference collectionReference = firebase.collection("ordenPedido");

      return collectionReference
        .doc(idOrdenPedido)
        .snapshots()
        .map((order) => OrdenPedidoMapper.ordenPedidoToEntity(OrdenPedidoModel.fromJson(order.id, order.data() as Map<String, dynamic>)));
    } catch (e) {
      throw Exception("Error al cargar carrito..., ${e.toString()}");            
    }

 }

  @override
  Stream<List<OrdenPedido>> getOrdersByCustomer({required String idCliente}) {
    try {
      final CollectionReference collectionReference = firebase.collection("ordenPedido");
      return collectionReference
        .where("cliente.id", isEqualTo: idCliente)
        .orderBy("fecha", descending: true)
        .snapshots()
        .map((response) => response.docs.map((order) => OrdenPedidoMapper.ordenPedidoToEntity(OrdenPedidoModel.fromJson(order.id, order.data() as Map<String, dynamic>))).toList());      
    } catch (e) {
      debugPrint("Error al cargar las ordenes ..., ${e.toString()}");
      throw Exception("Error al cargar las ordenes ..., ${e.toString()}");            
    }
  }
  
  @override
  Stream<List<OrdenPedido>> getOrdersByFilter({required String idCliente, required String state}) {
    try {
      final CollectionReference collectionReference = firebase.collection("ordenPedido");

      return collectionReference
        .where("cliente.id", isEqualTo: idCliente)
        .where("estado", isEqualTo: state)
        .orderBy("fecha", descending: true)
        .snapshots()
        .map((response) => response.docs.map((order) => OrdenPedidoMapper.ordenPedidoToEntity(OrdenPedidoModel.fromJson(order.id, order.data() as Map<String, dynamic>))).toList());
      

    } catch (e) {
      debugPrint("Error al cargar las ordenes ..., ${e.toString()}");
      throw Exception("Error al cargar las ordenes ..., ${e.toString()}");            
    }
  }
  
  @override
  Future<void> cancelOrder({required String idOrdenPedido}) async{
    try {
      final CollectionReference collectionReference = firebase.collection("ordenPedido");
      await collectionReference.doc(idOrdenPedido).update({"estado": "Pedido cancelado"});
    } catch (e) {
      throw Exception("Error al cancelar la orden. ${e.toString()}");            
    }
  }
  
  @override
  Future<void> deleteOrder({required String idOrdenPedido}) async{
    try {
      //TODO: Implementar la eliminación de la orden (Solo vista del usuario)
      final CollectionReference collectionReference = firebase.collection("ordenPedido");
      await collectionReference.doc(idOrdenPedido).update({"estado": "Pedido cancelado"});
    } catch (e) {
      throw Exception("Error al cancelar la orden. ${e.toString()}");            
    }
  }
}