import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({
    super.key,
    required this.maximiunWidth,
    required this.maximiunHeight, 
    required this.pathLottie, 
    required this.text,
  });

  final double maximiunWidth;
  final double maximiunHeight;
  final String pathLottie;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maximiunWidth,
      height: maximiunHeight,
      decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(25)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Lottie animation from assets folder - json
            Lottie.asset(pathLottie, width: 300, height: 300, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
