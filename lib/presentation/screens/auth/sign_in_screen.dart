import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/presentation/helpers/helpers.dart';
import 'package:la_carreta_express_cs/presentation/ui/input_decoration.dart';
import 'package:la_carreta_express_cs/presentation/widgets/shared/registered_trademark.dart';

class SignInScreen extends StatelessWidget {

  static const String name = 'sign_in_screen';

  const SignInScreen({super.key});
  
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
              const _SignInView(),     

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

class _SignInView extends StatelessWidget {
  const _SignInView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [     
          //Title - Sign In
          const Text("Sign In", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),),

          //Form
          const _FormSignIn(),

          //Controles adicionales
          const _ForgotPassword(),

          //Login button
          Center(
            child: FilledButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(300, 40)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                backgroundColor: MaterialStateProperty.all(const Color(0xff582F0E))
              ),
              onPressed: () => context.go('/'), 
              child: const Text("Sign In", style: TextStyle(fontSize: 17),)
            ),
          ),

          const SizedBox(height: 20),
          //No tienes una cuenta
          Center(
            child: TextButton(
              onPressed: () => context.go("/sign-up"), 
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: "¿No tienes una cuenta? ", style: TextStyle(fontSize: 15, color: Colors.black)),
                    TextSpan(text: "Registrate", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black))
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

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.go("/reset-password"),
        child: const Text("Olvidaste tu contraseña?", style: TextStyle(fontSize: 15, color: Colors.black))
      )
    );
  }
}

class _FormSignIn extends StatelessWidget {
  const _FormSignIn();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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

          const SizedBox(height: 10),

          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecorations.userUpdateInputDecoration(
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
      )
    );
  }
}