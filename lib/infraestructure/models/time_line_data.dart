import 'package:flutter/material.dart';

class TimelineData {
  final String idOrder;
  final List<ColorsTimeLine> colors;

  TimelineData({required this.idOrder, required this.colors});
}

class ColorsTimeLine {
  final Color indicatorColor;
  final Color beforeLineColor;
  final Color afterLineColor;
  final int index;
  final bool statePassed;

  ColorsTimeLine(
      {required this.index,
      required this.indicatorColor,
      required this.beforeLineColor,
      required this.afterLineColor,
      required this.statePassed});
}
