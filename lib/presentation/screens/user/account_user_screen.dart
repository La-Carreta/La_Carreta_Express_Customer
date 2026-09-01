import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/presentation/helpers/helpers.dart';
import 'package:la_carreta_express_cs/presentation/providers/auth/auth_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/customer/customer_provider.dart';
import 'package:la_carreta_express_cs/presentation/ui/input_decoration.dart';

class AccountUserScreen extends ConsumerWidget {
  static String name = 'account_user_screen';
  const AccountUserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(customerProvider);

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
                    backgroundColor: Colors.black54,
                    radius: 85,
                    backgroundImage: FadeInImage(
                      placeholder:
                          const AssetImage('assets/images/loading.gif'),
                      image: Image.network(
                        customer.imgUrl,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const CircularProgressIndicator();
                        },
                      ).image,
                    ).image,
                  ),
                ),
                const SizedBox(height: 15),
                _UpdateDataForm(customer: customer)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UpdateDataForm extends ConsumerStatefulWidget {
  final Cliente customer;
  const _UpdateDataForm({
    required this.customer,
  });

  @override
  UpdateDataFormState createState() => UpdateDataFormState();
}

class UpdateDataFormState extends ConsumerState<_UpdateDataForm> {
  bool _isEditingName = true;
  bool _isEditingLastName = true;
  bool _isEditingAddress = true;
  bool _isEditingPhoneNumber = true;
  bool _isEditingPassword = true;
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final direccionController = TextEditingController();
  final celularController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nombreController.text = widget.customer.nombre;
    apellidoController.text = widget.customer.apellido;
    direccionController.text = widget.customer.direccion;
    celularController.text = widget.customer.celular;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final globalKeyForm = GlobalKey<FormState>();
    return Form(
      key: globalKeyForm,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                colors: colors),
            readOnly: _isEditingName,
            validator: (value) {
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
                colors: colors),
            readOnly: _isEditingLastName,
            validator: (value) {
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
                colors: colors),
            readOnly: _isEditingAddress,
            validator: (value) => validateAddress(value ?? ""),
          ),
          const Divider(height: 1, color: Color(0xffe9ecef)),
          const SizedBox(height: 15),
          TextFormField(
            controller: celularController,
            keyboardType: TextInputType.phone,
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
                colors: colors),
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
                colors: colors),
            readOnly: _isEditingPassword,
            validator: (value) => validatePassword(value ?? ""),
          ),
          const SizedBox(height: 15),
          Center(
            child: FilledButton(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(const Size(300, 40)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xff023047)),
                ),
                onPressed: () {
                  final isValid = globalKeyForm.currentState!.validate();
                  if (!isValid) return;

                  final customerUpdated = widget.customer.copyWith(
                      nombre: nombreController.text.trim(),
                      apellido: apellidoController.text.trim(),
                      direccion: direccionController.text.trim(),
                      celular: celularController.text.trim(),
                      imgUrl: widget.customer.imgUrl);
                  final fullName =
                      "${customerUpdated.nombre} ${customerUpdated.apellido}";
                  ref
                      .read(customerProvider.notifier)
                      .updateCustomerData(customerUpdated);
                  ref.read(authProvider.notifier).updateProfile(fullName,
                      customerUpdated.imgUrl, passwordController.text.trim());
                  showCustomSnackbar(
                      context: context,
                      title: "Datos actualizados correctamente");
                },
                child: const Text(
                  "Actualizar Datos",
                  style: TextStyle(fontSize: 17),
                )),
          ),
        ],
      ),
    );
  }
}
