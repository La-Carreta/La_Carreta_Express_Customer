String? validateAddress(String value) {
  // La dirección debe tener al menos 10 caracteres.
  if (value.length < 5) {
    return "La dirección debe tener al menos 5 caracteres. ";
  }

  // La dirección debe contener al menos una letra.
  if (!value.contains(RegExp(r'[a-zA-Z]'))) {
    return "La dirección debe contener al menos una letra.";
  }

  // La dirección debe contener al menos un número.
  if (!value.contains(RegExp(r'[0-9]'))) {
    return "La dirección debe contener al menos un número";
  }

  return null;
}