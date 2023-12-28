import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/presentation/helpers/get_color_indicator.dart';

class IndicadorEstado extends StatelessWidget {  
  final String state;
  const IndicadorEstado({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: getColorByState(state),
        borderRadius: BorderRadius.circular(50),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
    );
  }
}
