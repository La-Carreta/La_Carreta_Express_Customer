import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {

  final String imgUrl;   
  const ImageBackground({super.key, required this.imgUrl});
  
  @override
  Widget build(BuildContext context) {
    bool isUrlValid = Uri.parse(imgUrl).isAbsolute;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isUrlValid
          ? NetworkImage(imgUrl) as ImageProvider<Object>
          : AssetImage(imgUrl),
          fit: BoxFit.cover
        ),   
      ),
    );
  }
}