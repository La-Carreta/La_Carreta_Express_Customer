import 'package:flutter/material.dart';

class RegisteredTradeMark extends StatelessWidget {
  const RegisteredTradeMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      color: const Color(0xffe9ecef),
      child: const Text("La Carreta Express App is a registered trademark. ™", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),),
    );
  }
}
