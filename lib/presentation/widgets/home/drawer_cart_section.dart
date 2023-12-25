import 'package:flutter/material.dart';

class DrawerCartSection extends StatelessWidget {
  const DrawerCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: (){}, //TODO: Implementar la apertura del drawer
          icon: const Icon(Icons.menu, size: 30,)
        ),
          
        IconButton(
          onPressed: (){}, //TODO: Implementar la redireccion al carrito
          icon: const Icon(Icons.shopping_cart_outlined, size: 30,)
        ),
      ],
    );
  }
}