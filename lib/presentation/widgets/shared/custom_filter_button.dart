import 'package:flutter/material.dart';

class CustomFilterButton extends StatelessWidget {
  
  final VoidCallback onPressed;
  const CustomFilterButton({Key? key, required this.onPressed}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: IconButton(
        onPressed: onPressed, 
        icon: const Icon(Icons.filter_list, size: 25)
      ),
    );
   }
}