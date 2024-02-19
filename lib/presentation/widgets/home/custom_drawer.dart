import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/presentation/helpers/user_data_formater.dart';
import 'package:la_carreta_express_cs/presentation/providers/auth/auth_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/customer/customer_provider.dart';

class CustomDrawer extends ConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const CustomDrawer({super.key, required this.scaffoldKey});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const _UserRow(),

              const SizedBox(height: 60),

              _MenuItem(icon: Icons.fastfood,title: "Menu", onTap: (){                
                context.go("/");
                Scaffold.of(context).closeDrawer();
              }),

              _MenuItem(icon: Icons.restaurant_menu,title: "Pedidos", color: Colors.transparent, onTap: (){ 
                context.push("/pedidos");
                Scaffold.of(context).closeDrawer();
              }),

              _MenuItem(icon: Icons.notifications,title: "Notificaciones", color: Colors.transparent, onTap: (){
                context.push("/notificaciones");
                Scaffold.of(context).closeDrawer();
              }),

              const Spacer(),

              _MenuItem(
                icon: Icons.logout_outlined,
                title: "Cerrar Sesión", 
                color: const Color(0xffFFD43B),
                onTap: ref.read(authProvider.notifier).logout
              ),
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

class _UserRow extends ConsumerWidget {
  const _UserRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerProvider);
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Avatar User
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: FadeInImage(
            placeholder: const AssetImage("assets/loaders/loading.gif"), 
            image: NetworkImage(customer.imgUrl.isEmpty ? "https://res.cloudinary.com/dwexseytn/image/upload/v1708297546/La_Carreta_Express/Avatar_users/no-profile-photo_nsgx2g.png" : customer.imgUrl),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
    
        const SizedBox(width: 10),
    
        //Name User
        SizedBox(
          width: size.width * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formatName(customer), style: const TextStyle(fontSize: 17)),
              Text(formatUsername(customer), style: TextStyle(fontSize: 15, color: Colors.grey[600]))
            ],
          ),
        ),

        const Spacer(),
        //Pencil edit
        IconButton(
          icon: const Icon(Icons.edit_note_outlined),
          onPressed: (){
            context.push("/account-user");
            Scaffold.of(context).closeDrawer();
          }, 
        )
      ],
    );
  }
}