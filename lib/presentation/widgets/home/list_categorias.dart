import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'package:la_carreta_express_cs/presentation/providers/categoria/categorias_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/platos/platos_provider.dart';

//TODO: Considerar el cambio de importacion en base al dataset a consumirse.

class ListCategorias extends ConsumerWidget {
  const ListCategorias({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriasList = ref.watch( categoriasProvider );
    final categoriaSeleccionada = ref.watch(categoriaSeleccionadaProvider);

    if(categoriasList.isEmpty) return const Center(child: CircularProgressIndicator());

    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only(left: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriasList.length,
        itemBuilder: (context, index) {
          final categoria = categoriasList[index];
          final optionSelected = categoriaSeleccionada;
          final isOptionSelected = optionSelected == index;

          return _ItemListCategorias(
            categoria: categoria, 
            onTap: (){
              ref.read(categoriaSeleccionadaProvider.notifier).state = index;
              ref.read( platosByCategoriaProvider.notifier ).loadPlatosByCategoria(categoria.nombre);
            }, 
            isOptionSelected: isOptionSelected
          );
        },
      ),
    );
  }
}

class _ItemListCategorias extends StatelessWidget {
  
  final Categoria categoria;
  final VoidCallback onTap;
  final bool isOptionSelected;
  
  const _ItemListCategorias({required this.categoria, required this.onTap, this.isOptionSelected = false});  

  @override
  Widget build(BuildContext context) {
    final colorLetter = isOptionSelected ? Colors.white : Colors.black;
    final backgroundOption = isOptionSelected ? const Color(0xff582F0E) : const Color(0xFFdee2e6);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: 170,
        height: 50,
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.only(left: 20, right: 5),

        decoration: BoxDecoration(
          color: backgroundOption,
          borderRadius: BorderRadius.circular(20)
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Icon
            CircleAvatar(
              backgroundImage: NetworkImage(categoria.urlImg),
              // child: Text("IC"),
            ), 
            const SizedBox(width: 10),
            //Name
            Text(categoria.nombre, style:  TextStyle(fontWeight: FontWeight.w600, color: colorLetter)),
          ],
        ),
      ),
    );
  }
}
