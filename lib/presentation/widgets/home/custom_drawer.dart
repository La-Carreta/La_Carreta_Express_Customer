import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  
  const CustomDrawer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //TODO: Considerar los datos logueados
              const _UserRow(),

              const SizedBox(height: 60),

              //TODO: Redireccionar a las pantallas y cambiar el fondo del boton seleccionado                     
              _MenuItem(icon: Icons.fastfood,title: "Menu", onTap: (){                
                context.go("/");
                Scaffold.of(context).closeDrawer();
              }),

              _MenuItem(icon: Icons.restaurant_menu,title: "Pedidos", color: Colors.transparent, onTap: (){ 
                context.push("/pedidos");
                Scaffold.of(context).closeDrawer();
              }),

              _MenuItem(icon: Icons.notifications,title: "Notificaciones", onTap: () => debugPrint("Notificaciones"), color: Colors.transparent,),

              const Spacer(),

              //TODO: Cerrar Sesion
              _MenuItem(icon: Icons.logout_outlined,title: "Cerrar Sesión", color: const Color(0xffFFD43B),onTap: ()=> context.go('/sign-in'),),
            ],
          ),
        ),   
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {

  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon, 
    required this.title, 
    this.color =const Color(0xffD0D8E0), 
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 5),
            Text(title, style: const TextStyle(fontSize: 15),)
          ],
        ),
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  const _UserRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Avatar User
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: const FadeInImage(
            placeholder: AssetImage("assets/loaders/loading.gif"), 
            image: NetworkImage("https://m.media-amazon.com/images/M/MV5BMWZiM2MyNjYtNDBmNS00YzM1LWJiNzctMjY3MmI0MjgwMjliXkEyXkFqcGdeQVRoaXJkUGFydHlJbmdlc3Rpb25Xb3JrZmxvdw@@._V1_.jpg"),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
    
        const SizedBox(width: 10),
    
        //Name User
        const Text("Alejandro González", style: TextStyle(fontSize: 17)),
    
        const Spacer(),
        //Pencil edit
        IconButton(onPressed: (){}, icon: const Icon(Icons.edit_note_outlined))
      ],
    );
  }
}