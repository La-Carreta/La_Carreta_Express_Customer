import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerCartSection extends StatelessWidget {
  const DrawerCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.menu, size: 30,)
        ),
          
        IconButton(
          onPressed: () => context.push("/cart"),
          icon: const Icon(Icons.shopping_cart_outlined, size: 30,)
        ),
      ],
    );
  }
}