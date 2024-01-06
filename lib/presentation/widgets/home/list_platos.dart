import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/presentation/providers/categoria/categorias_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/platos/platos_provider.dart';

//TODO: Ojo con este fragmento de codigo
class ListPlatos extends ConsumerWidget {
  const ListPlatos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platos = ref.watch(platosProvider);
    
    // if( platos.isEmpty ){ //&& categoria.isNotEmpty
    //   ref.read(platosProvider.notifier).loadPlatosByCategoria("Hamburguesas");
    // }

    if(platos.isEmpty) return const Center(child: CircularProgressIndicator());

    print("Plato 1: ${platos[0].nombre}");

    return SizedBox(
      width: double.infinity,
      height: 320,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _CardPlato(onTap: () => context.push('/info-plato',extra: index),);
        },
      ),
    );
  }
}

class _CardPlato extends StatelessWidget {  
  final VoidCallback? onTap;

  const _CardPlato({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
        color: const Color(0XFFFFFFFF),
        borderRadius: BorderRadius.circular(20),
        boxShadow:const [
          BoxShadow(
            color: Color(0xFFadb5bd),
            offset: Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 1,
          ),      
        ]
      );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 300,
        margin: const EdgeInsets.all(10),
        decoration: boxDecoration,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 10,
                child: Image.asset("assets/menu/fuego.png", width: 20,)
              ),
          
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FadeInImage(
                    placeholder: AssetImage("assets/no-data/no-image.jpg"), 
                    image: NetworkImage("https://res.cloudinary.com/dwexseytn/image/upload/v1703556404/La_Carreta_Express/Menu/Hamburguer/BK-Stacker-Doble-con-Queso_ujsfsw.png"),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ), 
              
                  //Title
                  const Text("Beef Burguer", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,overflow: TextOverflow.ellipsis), maxLines: 2),
                  //Litte description
                  const Text("Cheese Mozarella"),
                  const SizedBox(height: 15,),
                  //Costo
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: '\$', style: TextStyle(fontSize: 12, color: Color(0xffFF0000), fontWeight: FontWeight.bold)),
                        TextSpan(text: '17.25', style: TextStyle(fontSize: 16, color: Colors.black)),
                      ]
                    ),            
                  )          
                ],
              ),
            ],
          ),
        ),      
      ),
    );
  }
}
