import 'package:flutter/material.dart';

class ListPlatos extends StatelessWidget {
  const ListPlatos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 320,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20)
            ),
            margin: const EdgeInsets.all(10),
          );
        },
      ),
    );
  }
}
