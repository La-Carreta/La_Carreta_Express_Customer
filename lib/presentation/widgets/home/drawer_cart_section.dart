import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/presentation/providers/cart/cart_provider.dart';

class DrawerCartSection extends ConsumerWidget {
  const DrawerCartSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              Icons.menu,
              size: 30,
            )),
        Stack(
          children: [
            IconButton(
              onPressed: () => context.push("/cart"),
              icon: const Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
            ),
            if (cart.detallesPedido.isNotEmpty)
              //Indicator
              Positioned(
                right: 5,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.red),
                  child: const Text(
                    "*",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
