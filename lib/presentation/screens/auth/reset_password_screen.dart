import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:la_carreta_express_cs/presentation/helpers/helpers.dart';
import 'package:la_carreta_express_cs/presentation/providers/auth/auth_provider.dart';
import 'package:la_carreta_express_cs/presentation/ui/input_decoration.dart';
import 'package:la_carreta_express_cs/presentation/widgets/shared/registered_trademark.dart';
import 'package:la_carreta_express_cs/presentation/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

class ResetPasswordScreen extends StatelessWidget {

  static const String name = 'reset_password_screen';

  const ResetPasswordScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground( 
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,            
              children: [
                const SizedBox( height: 80 ),
                // Icon Banner
                const Icon( 
                  Icons.people_rounded, 
                  color: Colors.white,
                  size: 100,
                ),
                const SizedBox( height: 80 ),
                
                Container(
                  height: size.height - 260, // 80 los dos sizebox y 100 el ícono   
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(100)),
                  ),
                  child: const _ResetPasswordView(),
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}

class _ResetPasswordView extends StatelessWidget {
  const _ResetPasswordView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [     

        const Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(child: Text("¿Has olvidado tu contraseña?", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),)),
        ),
    
        const SizedBox(height: 30),
    
        //Form
        const _FormResetPassword(),
    
        const SizedBox(height: 20),
        
        //No tienes una cuenta
        Center(
          child: TextButton(
            onPressed: () => context.go("/login"), 
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
        const Spacer(),
        const RegisteredTradeMark(),
      ],
    );
  }
}

class _FormResetPassword extends ConsumerWidget {
  const _FormResetPassword();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final colors = Theme.of(context).colorScheme;
    final formKey = GlobalKey<FormState>();

    void showEmailSentDialog() async{
      return showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text("Correo Enviado"),
            content: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Lottie.asset("assets/lottie/json/email-sent.json", height: 150, width: 150)),
                  const Text("NOTA: ", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
                  Text("Hemos enviado un correo a ${emailController.text} con las instrucciones para restablecer tu contraseña", style: const TextStyle(color: Colors.black, fontSize: 17)),
                ],
              ),
            ),
            actions: [
              FilledButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(100, 40)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  backgroundColor: MaterialStateProperty.all(const Color(0xffe63946))
                ),
                onPressed: (){
                  context.pop();
                  context.go("/login");
                },
                child: const Text("Volver al login", style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          );
        },
      );
    }


    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: UniqueKey(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(      
          children: [
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecorations.authInputDecoration(
                  hintText: "Email", 
                  labelText: "Email",
                  prefixIcon: Icons.alternate_email,
                  colors: colors
                ),
                validator: (value) => validateEmail(value ?? ''),            
              ),
            ),
      
            const SizedBox(height: 30),
            //Reset button
            Center(
              child: FilledButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(300, 40)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                  backgroundColor: MaterialStateProperty.all(Colors.black)
                ),
                onPressed: (){
                  if(!formKey.currentState!.validate()) return;
                  debugPrint("Restablecer Contraseña");
                  ref.read(authProvider.notifier).resetAccount(emailController.text, "Error al restablecer contraseña");
                  showEmailSentDialog();
                }, 
                child: const Text("Restablecer Contraseña", style: TextStyle(fontSize: 17),)
              ),
            ),
         ],        
        )
      ),
    );
  }
}