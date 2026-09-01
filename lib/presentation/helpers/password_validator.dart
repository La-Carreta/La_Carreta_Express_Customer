String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Por favor ingrese una contraseña';
  }

  final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])');
  if (value.length < 8 || !regex.hasMatch(value)) {
    return '''
      La contraseña debe:
      - Tener al menos 8 caracteres
      - Contener al menos una letra mayúscula
      - Contener al menos una letra minúscula 
      - Contener al menos un número
      ''';
  }

  return null;
}
