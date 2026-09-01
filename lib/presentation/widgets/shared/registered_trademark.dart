import 'package:flutter/material.dart';

class RegisteredTradeMark extends StatelessWidget {
  final double width;
  const RegisteredTradeMark({super.key, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      alignment: Alignment.center,
      color: const Color(0xffe9ecef),
      child: const Text(
        "La Carreta Express App is a registered trademark. ™",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }
}
