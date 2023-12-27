import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {

  static const String name = 'sign_up_screen';

  const SignUpScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('SignuPScreen'),
      ),
    );
  }
}