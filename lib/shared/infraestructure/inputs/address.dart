// Define input validation errors
import 'package:formz/formz.dart';

enum AddressError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Address extends FormzInput<String, AddressError>{
  // Call super.pure to represent an unmodified form input.
  const Address.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Address.dirty([super.value = '']) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == AddressError.empty) return 'El campo es requerido';
    if (displayError == AddressError.format) return 'No tiene formato de dirección';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  AddressError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return AddressError.empty;
    if (value.length < 5) return AddressError.format;

    return null;
  }
}
