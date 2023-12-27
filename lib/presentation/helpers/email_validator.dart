String? validateEmail(String email) {
  // Verifica si el correo electrónico es nulo o vacío
  if (email.isEmpty) {
    return "Por favor ingrese un email";
  }
  
  // Utiliza una expresión regular para validar el formato del correo electrónico
  // Esta expresión regular verifica si el correo electrónico tiene un formato válido
  // basado en las especificaciones RFC 5322
  final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
  if(email.length < 8 || !regex.hasMatch(email)){
    return '''
      El email no es válido.
    ''';
  }

  return null;
}
