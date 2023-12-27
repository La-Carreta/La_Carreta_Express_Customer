import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/presentation/widgets/shared/custom_back_button.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const String name = 'cart_screen';

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
            left: size.width * 0.40,//150
            child: const Text("Carrito", style: TextStyle(fontSize: 30, color: Colors.white),)
          ),

          Positioned(
            bottom: 0,
            left: 0,
            child: _DetallePedido(maximiunHeight: size.height * 0.80, maximiunWidth: size.width,)
          ),
        ],
      ),
    );
  }
}

class _DetallePedido extends StatelessWidget {
  final double maximiunHeight;
  final double maximiunWidth;

  const _DetallePedido({
    required this.maximiunHeight, required this.maximiunWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maximiunWidth,
      height: maximiunHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: const BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [          
          //Title and cost
          const Text("Detalle del Pedido", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),),

          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 15,
              itemBuilder: (context, index) {
                return _ItemCartPlato(maximiunWidth:maximiunWidth);
              },
            )
          ),

          const SizedBox(height: 15),
          const Text("Observaciones", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
          
          TextFormField(
            minLines: 3,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
          ),

          const SizedBox(height: 10),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("\$40.70", style: TextStyle(fontSize: 18,  fontWeight: FontWeight.bold))
            ],
          ),

          FilledButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(170, 40)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
              backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
            ),
            onPressed: (){}, 
            child: const Text("Realizar Pedido", style: TextStyle(fontWeight: FontWeight.bold),),                
          ),
        ],
      ),
    );
  }
}

class _ItemCartPlato extends StatelessWidget {
  final double maximiunWidth;
  const _ItemCartPlato({
    required this.maximiunWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffe9ecef))
      ),
      child: Row(
        children: [
          //Img del plato
          Image.network("https://res.cloudinary.com/dwexseytn/image/upload/v1703556398/La_Carreta_Express/Menu/Hamburguer/Veggie-800x800-2_v6aq06.png", width: 80, fit: BoxFit.cover,), 
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Beef Burguer", overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                Text("Cheese Mozarrella"),
                SizedBox(height: 15),          
              ],
            ),
          ),

          SizedBox(
            width: maximiunWidth * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.remove), 
                      color: Colors.white,
                      style: ButtonStyle(                        
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(126, 88, 47, 14))
                      ),
                    ),
                    const Text('15'),
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(Icons.add), 
                      color: Colors.white,
                      style: ButtonStyle(                        
                        backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
                      ),
                    ),
                  ],
                ),
                const Text('\$6.79', style: TextStyle(fontSize: 17),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
