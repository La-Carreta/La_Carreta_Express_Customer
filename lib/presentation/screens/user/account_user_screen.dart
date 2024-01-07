import 'package:flutter/material.dart';
import 'package:la_carreta_express_cs/presentation/helpers/helpers.dart';
import 'package:la_carreta_express_cs/presentation/ui/input_decoration.dart';

class AccountUserScreen extends StatelessWidget {
  
  static String name = 'account_user_screen';
  const AccountUserScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Account"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Foto
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.brown.shade500,
                    radius: 85,
                    backgroundImage: const NetworkImage(            
                      "https://media.ambito.com/p/96594bdd7f10a6e04e09b1083eb4995b/adjuntos/239/imagenes/038/792/0038792145/dogecoin-memejpg.jpg",                 
                    ),
                  ),
                ),
            
                const SizedBox(height: 15),
                const _UpdateDataForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UpdateDataForm extends StatelessWidget {
   
  const _UpdateDataForm();
  
  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    nombreController.text = "Alejandro Gonzalez";
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: UniqueKey(),
      child: Column(
        children: [
          TextFormField(
            controller: nombreController,
            decoration: InputDecorations.authPasswordInputDecoration(
              hintText: "Nombre", 
              labelText: "Nombre",
              suffixIcon: Icons.edit,
              onPressed: () {
                
              },
              prefixIcon: Icons.people,
              colors: colors
            ),
            readOnly: true,
            validator: (value){
              if (value!.isEmpty) {
                return 'Por favor ingrese su nombre.';
              }
              return null;
            },
          ),

          const Divider(height: 1, color: Color(0xffe9ecef)),
          const SizedBox(height: 15),

          TextFormField(
            controller: nombreController,
            decoration: InputDecorations.authPasswordInputDecoration(
              hintText: "Apellido", 
              labelText: "Apellido",
              suffixIcon: Icons.edit,
              onPressed: () {
                
              },
              prefixIcon: Icons.people,
              colors: colors
            ),
            readOnly: true,
            validator: (value){
              if (value!.isEmpty) {
                return 'Por favor ingrese su apellido.';
              }
              return null;
            },
          ),

          const Divider(height: 1, color: Color(0xffe9ecef)),
          const SizedBox(height: 15),

          TextFormField(
            controller: nombreController,
            decoration: InputDecorations.authPasswordInputDecoration(
              hintText: "Dirección", 
              labelText: "Dirección",
              suffixIcon: Icons.edit,
              onPressed: () {
                
              },
              prefixIcon: Icons.map,
              colors: colors
            ),
            readOnly: true,
            validator: (value) => validateAddress(value ?? ""),
          ),

          const Divider(height: 1, color: Color(0xffe9ecef)),
          const SizedBox(height: 15),

          TextFormField(
            controller: nombreController,
            decoration: InputDecorations.authPasswordInputDecoration(
              hintText: "Celular", 
              labelText: "Celular",
              suffixIcon: Icons.edit,
              onPressed: () {
                
              },
              prefixIcon: Icons.phone,
              colors: colors
            ),
            readOnly: true,
            validator: (value) => validatePhoneNumber(value ?? ''), 
          ),

          const Divider(height: 1, color: Color(0xffe9ecef)),
          const SizedBox(height: 15),

          TextFormField(
            obscureText: true,
            controller: nombreController,
            decoration: InputDecorations.authPasswordInputDecoration(
              hintText: "Password", 
              labelText: "Password",                  
              suffixIcon: Icons.edit,
              onPressed: () {
                
              },
              prefixIcon: Icons.lock,
              colors: colors
            ),
            readOnly: true,
            validator: (value) => validatePassword(value ?? ""),
          ),

          const SizedBox(height: 15),

          Center(
            child: FilledButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 40)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
              ),
              onPressed: () => debugPrint("Actualizar Datos"), 
              child: const Text("Actualizar Datos", style: TextStyle(fontSize: 17),)
            ),
          ),
        ],
      ),
    );
  }
}