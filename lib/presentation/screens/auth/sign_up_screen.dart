import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/presentation/ui/input_decoration.dart';
import 'package:la_carreta_express_cs/presentation/widgets/shared/registered_trademark.dart';
import 'package:la_carreta_express_cs/presentation/helpers/helpers.dart';

class SignUpScreen extends StatelessWidget {

  static const String name = 'sign_up_screen';

  const SignUpScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              //Shapes
              Positioned(
                top: -80,
                right: -50,
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/shapes/bubble.png"), fit: BoxFit.cover)                  
                  ),
                ),
              ),

              //Form
              const _SignUpView(),     

              //Marca
              Positioned(
                bottom: 0,
                child: RegisteredTradeMark(width: size.width)
              ),
            ],
          ),
        ),
      )
    );
  }
}

class _SignUpView extends StatelessWidget {
  const _SignUpView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [     
              //Title - Sign Up
              const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),),
          
              //Form
              const _FormSignUp(),
          
              const SizedBox(height: 10),
           
              Center(
                child: FilledButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(300, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                    backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
                  ),
                  onPressed: () => debugPrint("Sign Up"), 
                  child: const Text("Sign Up", style: TextStyle(fontSize: 17),)
                ),
              ),
          
              const SizedBox(height: 20),
              //No tienes una cuenta
              Center(
                child: TextButton(
                  onPressed: () => context.go("/sign-in"), 
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: "¿Ya tienes una cuenta? ", style: TextStyle(fontSize: 15, color: Colors.black)),
                        TextSpan(text: "Inicia Sesión", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black))
                      ]
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormSignUp extends StatelessWidget {
  const _FormSignUp();

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController();
    final apellidoController = TextEditingController();
    final direccionController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final celularController = TextEditingController();

    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: UniqueKey(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(      
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.45,
                child: TextFormField(
                  controller: nombreController,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: "Nombre", 
                    labelText: "Nombre",
                    prefixIcon: Icons.person,
                    colors: colors
                  ),
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Por favor ingrese su nombre.';
                    }
                    return null;
                  },
                ),
              ),
          
              SizedBox(
                width: size.width * 0.45,
                child: TextFormField(
                  controller: apellidoController,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: "Apellido", 
                    labelText: "Apellido",
                    prefixIcon: Icons.person,
                    colors: colors
                  ),
                  validator: (value){
                    if (value!.isEmpty) {
                      return 'Por favor ingrese su apellido.';
                    }
                    return null;
                  },
                ),
              ),          
            ],
          ),
      
          TextFormField(
            controller: direccionController,
            decoration: InputDecorations.authInputDecoration(
              hintText: "Dirección", 
              labelText: "Dirección",
              prefixIcon: Icons.map_sharp,
              colors: colors
            ),
            validator: (value) => validateAddress(value ?? ""),
          ),
      
          const SizedBox(height: 10),
      
          TextFormField(
            controller: celularController,
            keyboardType: TextInputType.phone,
            decoration: InputDecorations.authInputDecoration(
              hintText: "Celular", 
              labelText: "Celular",
              prefixIcon: Icons.phone,
              colors: colors
            ),
            validator: (value) => validatePhoneNumber(value ?? ''),
          ),
      
          const SizedBox(height: 10),
      
          TextFormField(
            controller: emailController,
            decoration: InputDecorations.authInputDecoration(
              hintText: "Email", 
              labelText: "Email",
              prefixIcon: Icons.alternate_email,
              colors: colors
            ),
            validator: (value) => validateEmail(value ?? ''),
          ),
      
          const SizedBox(height: 10),
      
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecorations.authPasswordInputDecoration(
              hintText: "********", 
              labelText: "Password",
              prefixIcon: Icons.password,
              colors: colors, 
              suffixIcon: Icons.remove_red_eye, 
              onPressed: () {  }
            ),
            validator: (value) => validatePassword(value ?? ""),
          ),      
        ],        
      ),
    );
  }
}