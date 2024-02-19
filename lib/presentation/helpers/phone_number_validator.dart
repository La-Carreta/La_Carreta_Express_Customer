String? validatePhoneNumber(String phoneNumber) {
  // Verifica si el correo electrónico es nulo o vacío
  if (phoneNumber.isEmpty) {
    return "Por favor ingrese su número de celular.";
  }

  if (phoneNumber.length < 10) {
    return "El número ingresado es inferior a 10 caracteres.";
  }

  if (phoneNumber.length > 10) {
    return "El número ingresado es superior a 10 caracteres.";
  }

  final regex = RegExp("[09]{1}[0-9]{8}");

  // El número de celular debe seguir el formato XX-XXX-XXX-XXX.
  if (!regex.hasMatch(phoneNumber)) {
    return "El número ingresado es incorrecto.";
  }

  return null;
}
