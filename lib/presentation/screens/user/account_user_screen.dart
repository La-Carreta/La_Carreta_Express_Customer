import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class _UpdateDataForm extends ConsumerStatefulWidget {
   
  const _UpdateDataForm();

  @override
  UpdateDataFormState createState() => UpdateDataFormState();
}

class UpdateDataFormState extends ConsumerState<_UpdateDataForm> {

  bool _isEditingName = true;
  bool _isEditingLastName = true;
  bool _isEditingAddress = true;
  bool _isEditingPhoneNumber = true;
  bool _isEditingPassword = true;

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final apellidoController = TextEditingController();
    final direccionController = TextEditingController();
    final celularController = TextEditingController();
    final passwordController = TextEditingController();

    nombreController.text = "Alejandro Gonzalez";
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: UniqueKey(),
      child: Column(
        children: [
          TextFormField(
            controller: nombreController,
            decoration: InputDecorations.userUpdateInputDecoration(
              hintText: "Nombre", 
              labelText: "Nombre",
              suffixIcon: _isEditingName ? Icons.edit : Icons.save,
              onPressed: () {
                setState(() {
                  _isEditingName = !_isEditingName;
                });
              },
              prefixIcon: Icons.people,
              colors: colors
            ),
            readOnly: _isEditingName,
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
            controller: apellidoController,
            decoration: InputDecorations.userUpdateInputDecoration(
              hintText: "Apellido", 
              labelText: "Apellido",
              suffixIcon: _isEditingLastName ? Icons.edit : Icons.save,
              onPressed: () {
                setState(() {
                  _isEditingLastName = !_isEditingLastName;
                });                                
              },
              prefixIcon: Icons.people,
              colors: colors
            ),
            readOnly: _isEditingLastName,
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
            controller: direccionController,
            decoration: InputDecorations.userUpdateInputDecoration(
              hintText: "Dirección", 
              labelText: "Dirección",
              suffixIcon: _isEditingAddress ? Icons.edit : Icons.save,
              onPressed: () {
                setState(() {
                  _isEditingAddress = !_isEditingAddress;
                });                
              },
              prefixIcon: Icons.map,
              colors: colors
            ),
            readOnly: _isEditingAddress,
            validator: (value) => validateAddress(value ?? ""),
          ),

          const Divider(height: 1, color: Color(0xffe9ecef)),
          const SizedBox(height: 15),

          TextFormField(
            controller: celularController,
            decoration: InputDecorations.userUpdateInputDecoration(
              hintText: "Celular", 
              labelText: "Celular",
              suffixIcon: _isEditingPhoneNumber ? Icons.edit : Icons.save,
              onPressed: () {
                setState(() {
                  _isEditingPhoneNumber = !_isEditingPhoneNumber;
                });                
              },
              prefixIcon: Icons.phone,
              colors: colors
            ),
            readOnly: _isEditingPhoneNumber,
            validator: (value) => validatePhoneNumber(value ?? ''), 
          ),

          const Divider(height: 1, color: Color(0xffe9ecef)),
          const SizedBox(height: 15),

          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecorations.userUpdateInputDecoration(
              hintText: "Password", 
              labelText: "Password",                  
              suffixIcon: _isEditingPassword ? Icons.edit : Icons.save,
              onPressed: () {
                setState(() {
                  _isEditingPassword = !_isEditingPassword;
                });
              },
              prefixIcon: Icons.lock,
              colors: colors
            ),
            readOnly: _isEditingPassword,
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