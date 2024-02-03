import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/orden_pedido.dart';
import 'package:la_carreta_express_cs/infraestructure/models/time_line_data.dart';
import 'package:la_carreta_express_cs/presentation/helpers/get_current_status_index.dart';

final ordenPedidoInfoTimelineProvider = StateNotifierProvider<OrdenPedidoInfoTimelineNotifier, Map<String, TimelineData>>((ref){
  return OrdenPedidoInfoTimelineNotifier();
});

typedef OrdenPedidoCallBackById = Future<OrdenPedido> Function({required String idOrdenPedido});

class OrdenPedidoInfoTimelineNotifier extends StateNotifier<Map<String, TimelineData>>{
  OrdenPedidoInfoTimelineNotifier():super({});

  Future<void> getTimelineData({required String statusOrder, required String idOrder}) async{
    final index = getCurrentStatusIndex(statusOrder);
    final List<ColorsTimeLine> listColors = [];

    if( state[idOrder] != null) return;    

    for(int i = 1; i <= statusList.length; i++){
      if(index > i){
        listColors.add(ColorsTimeLine(
          index: i,
          indicatorColor: Colors.green,
          beforeLineColor: Colors.green,
          afterLineColor: Colors.green,
          statePassed: true
        ));
      } else if( index == i ){
        listColors.add(ColorsTimeLine(
          index: i,
          indicatorColor: const Color(0xFF2B619C),
          beforeLineColor: index == 1 ? Colors.grey : Colors.green,
          afterLineColor: Colors.grey,
          statePassed: true
        ));
      } else{
          listColors.add(ColorsTimeLine(
            index: i,
            indicatorColor: Colors.grey,
            beforeLineColor: Colors.grey,
            afterLineColor: Colors.grey,
            statePassed: false
        ));
      }
    }
  
    //Constructor objeto TimelineData
    final timelineData = TimelineData(
      idOrder: idOrder,
      colors: listColors
    );

    await Future.delayed(const Duration(milliseconds: 300), (){
      state = {...state, idOrder: timelineData};
    } );

  }
}