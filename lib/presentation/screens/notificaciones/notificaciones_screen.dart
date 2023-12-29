import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/presentation/helpers/get_link_icon.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class NotificacionesScreen extends StatelessWidget {
  
  static String name = 'notificaciones_screen';

  const NotificacionesScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(      
      body: Stack(
        children: [
          //Background
          const ImageBackground(imgUrl: "assets/background/main.png"),

          //Back button
          const Positioned(
            top: 50,
            left: 20,
            child: CustomBackButton()
          ),

          //Title
          Positioned(
            top: 55,
            left: size.width * 0.30,//150
            child: const Text("Notificaciones", style: TextStyle(fontSize: 30, color: Colors.white),)
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: _NotificacionesView(maximiunHeight: size.height * 0.85, maximiunWidth: size.width,)
          ),
        ],
      )
    );
  }
}

class _NotificacionesView extends StatelessWidget {
  final double maximiunHeight;
  final double maximiunWidth;

  const _NotificacionesView({
    required this.maximiunHeight, required this.maximiunWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maximiunWidth,
      height: maximiunHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(25)),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) {
          final imgUrl = getUrlIconNotificaciones();
          return _Notification(maximiunWidth:maximiunWidth, imgUrl: imgUrl,);
        },
      ),
    );
  }
}

class _Notification extends StatelessWidget {
  final double maximiunWidth;
  final String imgUrl;

  const _Notification({
    required this.maximiunWidth, 
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffe9ecef))
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(imgUrl, width: 60, fit: BoxFit.cover)
          ),
          
          const SizedBox(width: 10),

          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hey Alejandro..", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text("Tu orden #0316196 esta lista.")
            ],
          )
        ],
      ),
    );
  }
}