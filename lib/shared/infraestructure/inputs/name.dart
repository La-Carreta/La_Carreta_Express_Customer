// Define input validation errors
import 'package:formz/formz.dart';

enum NameError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Name extends FormzInput<String, NameError> {
  // Call super.pure to represent an unmodified form input.
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Name.dirty([super.value = '']) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == NameError.empty) return 'El campo es requerido';
    if (displayError == NameError.format) return 'No tiene formato de nombre';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return NameError.empty;
    if (value.length < 2) return NameError.format;

    return null;
  }
}
