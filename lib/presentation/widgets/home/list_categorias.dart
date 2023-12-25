import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/domain/entities/categoria.dart';

class ListCategorias extends StatelessWidget {
  const ListCategorias({super.key});

  @override
  Widget build(BuildContext context) {
    final cat = Categoria(nombre: "Hamburguer");
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) {
          return _ItemListCategorias(cat);
        },
      ),
    );
  }
}

class _ItemListCategorias extends StatelessWidget {
  
  final Categoria categoria;
  const _ItemListCategorias(this.categoria);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFdee2e6),
        borderRadius: BorderRadius.circular(20)
      ),
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
          Text(categoria.nombre, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
