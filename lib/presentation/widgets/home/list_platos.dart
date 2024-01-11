import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/domain/entities/plato.dart';
import 'package:la_carreta_express_cs/presentation/providers/providers.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

class ListPlatos extends ConsumerWidget {
  const ListPlatos({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final categoria = ref.watch(categoriaProvider);
    ref.watch( platosByCategoriaProvider.notifier ).loadPlatosByCategoria(categoria);
    
    final initialLoadingPlatos = ref.watch(initialLoadingPlatosProvider);
    if(initialLoadingPlatos) return const FullScreenLoader();

    final platos = ref.watch(platosByCategoriaProvider);  
    if(platos.isEmpty) return const Center(child: _NoData());
    return SizedBox(
      width: double.infinity,
      height: 320,
      child: ListView.builder(
        itemCount: platos.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final plato = platos[index];
          return _CardPlato(
            onTap: () => context.push('/info-plato', extra: index),
            plato: plato
          );
        },
      ),
    );
  }
}

class _CardPlato extends StatelessWidget {  
  final VoidCallback? onTap;
  final Plato plato;
  
  const _CardPlato({
    this.onTap, 
    required this.plato,
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: boxDecoration,
        child: Center(
          child: Stack(
            children: [
              if(plato.popular)...[
                Positioned(
                  right: 0,
                  top: 10,
                  child: Image.asset("assets/menu/fuego.png", width: 20,)
                )
              ],          
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/no-data/no-image.jpg"), 
                        image: NetworkImage(plato.platoUrl),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), 
              
                  //Title
                  Text(plato.nombre, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18,overflow: TextOverflow.ellipsis), maxLines: 2),
                  //Litte description
                  Text(plato.descripcionCorta, textAlign: TextAlign.justify),
                  const SizedBox(height: 15,),
                  //Costo
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(text: '\$', style: TextStyle(fontSize: 12, color: Color(0xffFF0000), fontWeight: FontWeight.bold)),
                          TextSpan(text: plato.precio.toString(), style: const TextStyle(fontSize: 16, color: Colors.black)),
                        ]
                      ),            
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

class _NoData extends StatelessWidget {
  const _NoData();
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: size.width,
      height: 320,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/json/Not-Found.json"),
          const Text(
            "Platos no disponibles, \n vuelva a intentarlo más tarde.", 
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          )
        ],
      ),
    );
  }
}