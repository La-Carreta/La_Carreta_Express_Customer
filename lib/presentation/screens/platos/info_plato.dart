import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/presentation/providers/platos/plato_info_provider.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class InfoPlatoScreen extends ConsumerWidget {
   
  static const String name = 'info_plato_screen';
  final String platoId;
  const InfoPlatoScreen({super.key, required this.platoId});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(platoInfoProvider.notifier).loadPlato(platoId);    
    final platoProvider = ref.watch(platoInfoProvider);
    if(platoProvider.isEmpty) return const Center(child: CircularProgressIndicator(),);
    if(!platoProvider.containsKey(platoId)) return const Scaffold(body:Center(child:Text("Plato no encontrado")));
    final plato = platoProvider[platoId];

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

          Positioned(
            bottom: 0,
            left: 0,
            child: _InfoPlatoView(maximiunHeight: size.height * 0.75, maximiunWidth: size.width, plato: plato!)
          ),

          //Img plato
          Positioned(
            top: 100,
            left: size.width * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: FadeInImage(
                placeholder: const AssetImage("assets/loaders/loading.gif"), 
                image: NetworkImage(plato.platoUrl),
                width: size.width * 0.70,
                height: 225,                
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPlatoView extends StatelessWidget {
  final double maximiunHeight;
  final double maximiunWidth;
  final Plato plato;
  
  const _InfoPlatoView({
    required this.maximiunHeight, 
    required this.maximiunWidth,
    required this.plato
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maximiunWidth,
      height: maximiunHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [          
          const SizedBox(height: 100),

          //Title and cost
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: maximiunWidth * 0.6,
                child: Text(plato.nombre, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25), maxLines: 2, overflow: TextOverflow.ellipsis)
              ),

              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "\$ ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xffFF0000))),
                    TextSpan(text: plato.precio.toStringAsFixed(2), style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xff000000)))
                  ]
                )
              ),              
            ],
          ),

          Text(plato.descripcionCorta),
          const SizedBox(height: 15),          
          //Informacion del plato (tiempo - energia calorica - puntuacion)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ItemDescriptionPlato(maximiunWidth: maximiunWidth, imgUrl: 'https://res.cloudinary.com/dwexseytn/image/upload/v1703712712/La_Carreta_Express/Various_icons/favorito_hvexto.png', data: '4.5'),
              _ItemDescriptionPlato(maximiunWidth: maximiunWidth, imgUrl: 'https://res.cloudinary.com/dwexseytn/image/upload/v1703712714/La_Carreta_Express/Various_icons/fuego_jwrmab.png', data: "${plato.numCalorias} cal",),
              _ItemDescriptionPlato(maximiunWidth: maximiunWidth, imgUrl: 'https://res.cloudinary.com/dwexseytn/image/upload/v1703712712/La_Carreta_Express/Various_icons/despertador_dgttcz.png', data: plato.tiempoPreparacion,),
            ],
          ),
          
          const SizedBox(height: 15),
          //Descripcion larga del plato
          Text(plato.descripcion, style: const TextStyle(fontSize: 16),textAlign: TextAlign.justify),
          const Spacer(),
          //Botones          
          Row(
            children: [
              FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
                ),
                onPressed: (){}, 
                child: const Icon(Icons.remove),                
              ),
              const SizedBox(width: 5,),
              const Text("10", style: TextStyle(fontSize: 25),),
              const SizedBox(width: 5,),

              FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
                ),
                onPressed: (){}, 
                child: const Icon(Icons.add),                
              ),

              const Spacer(),

              FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
                ),
                onPressed: (){}, 
                child: const Text("Agregar al carrito"),                
              ),

            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class _ItemDescriptionPlato extends StatelessWidget {
  final double maximiunWidth;
  final String imgUrl;
  final String data;

  const _ItemDescriptionPlato({
    required this.maximiunWidth, 
    required this.imgUrl, 
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maximiunWidth * 0.3,
      height: 25,
      child: Row(
        children: [
          Image.network(imgUrl),
          const SizedBox(width: 10),
          Text(data)
        ],
      ),
    );
  }
}