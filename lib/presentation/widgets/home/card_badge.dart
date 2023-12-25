import 'package:flutter/material.dart';

class CardPresentationHome extends StatelessWidget {

  final String imgUrl;
  final String personUrl;

  const CardPresentationHome({Key? key, required this.imgUrl, required this.personUrl}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        //Background Containter
        _BgBadge(
          imgUrl: imgUrl, 
          heigh: 180
        ),

        //Person Img               
        Positioned(
          top: 10,
          right: size.width * 0.05,
          child: _BgBadge(
            imgUrl: personUrl, 
            width: 100, 
            heigh: 160, 
            boxFit: BoxFit.fitHeight
          )
        ),
        
        //Texto
        Positioned(
          top: 40,
          left: 35,
          child: _TextCard(size: size),
        )
      ],
    );
  }
}

class _TextCard extends StatelessWidget {
  const _TextCard({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),          
      alignment: Alignment.center,
      width: size.width * 0.50,
      height: 100,
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(text: "Todo lo que deseas comer,", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black)),
            TextSpan(text: " a un clic de distancia.", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Color(0xFFED4C4C)))
          ]
        ),
      ),
    );
  }
}

class _BgBadge extends StatelessWidget {
  const _BgBadge({
    required this.imgUrl, 
    this.width = double.infinity, 
    required this.heigh, 
    this.boxFit = BoxFit.cover,
  });

  final String imgUrl;
  final double width;
  final double heigh;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    bool isUrlValid = Uri.parse(imgUrl).isAbsolute;
    return Container(
      width: width,
      height: heigh,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isUrlValid
          ? NetworkImage(imgUrl) as ImageProvider<Object>
          : AssetImage(imgUrl),
          fit: boxFit
        ),   
        borderRadius: BorderRadius.circular(20)      
      ),
    );
  }
}