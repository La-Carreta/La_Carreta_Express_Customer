import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/presentation/helpers/helpers.dart';
import 'package:la_carreta_express_cs/presentation/ui/input_decoration.dart';
import 'package:la_carreta_express_cs/presentation/widgets/shared/registered_trademark.dart';

class ResetPasswordScreen extends StatelessWidget {

  static const String name = 'reset_password_screen';

  const ResetPasswordScreen({super.key});
  
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
              const _ResetPasswordView(),     

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

class _ResetPasswordView extends StatelessWidget {
  const _ResetPasswordView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [     
          //Title - Sign In
          const Text("¿Has olvidado la contraseña?", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),),

          const SizedBox(height: 30),

          //Form
          const _FormResetPassword(),

          const SizedBox(height: 30),
          //Reset button
          Center(
            child: FilledButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 40)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
              ),
              onPressed: () => debugPrint("Restablecer Contraseña"), 
              child: const Text("Restablecer Contraseña", style: TextStyle(fontSize: 17),)
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
                    TextSpan(text: "O ", style: TextStyle(fontSize: 15, color: Colors.black)),
                    TextSpan(text: "Inicia Sesión", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black))
                  ]
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormResetPassword extends StatelessWidget {
  const _FormResetPassword();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final colors = Theme.of(context).colorScheme;

    return Form(
      key: UniqueKey(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(      
        children: [
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
       ],        
      )
    );
  }
}