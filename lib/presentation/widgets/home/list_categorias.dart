import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';
import 'package:la_carreta_express_cs/presentation/providers/providers.dart';
import 'package:provider/provider.dart';

class ListCategorias extends StatelessWidget {
  const ListCategorias({super.key});

  @override
  Widget build(BuildContext context) {
    final cat = Categoria(nombre: "Hamburguer");
    final categoriaProvider = context.watch<CategoriaOptionProvider>();
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) {
          final optionSelected = categoriaProvider.optionSelected;
          final isOptionSelected = optionSelected == index;
          return _ItemListCategorias(categoria: cat, onTap: ()=> categoriaProvider.optionSelected = index, isOptionSelected: isOptionSelected);
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
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundOption,
          borderRadius: BorderRadius.circular(20)
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //TODO: Traer data de la base de datos o json file
            //Icon
            const CircleAvatar(
              child: Text("IC"),
            ),
      
            //TODO: Traer data de la base de datos o json file
            //Name
            Text(categoria.nombre, style:  TextStyle(fontWeight: FontWeight.w600, color: colorLetter)),
          ],
        ),
      ),
    );
  }
}
