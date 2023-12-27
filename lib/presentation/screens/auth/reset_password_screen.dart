import 'package:flutter/material.dart';

class ResetPassworScreen extends StatelessWidget {
    static const String name = 'reset_password_screen';
 
  const ResetPassworScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('ResetPassworScreen'),
      ),
    );
  }
}