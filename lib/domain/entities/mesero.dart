class Mesero {
  final String id;
  final String nombre;
  final String apellido;
  final String estado;
  final String areaTrabajo;
  final String celular;
  final String email;
  final String imgUrl;
  final String uuid;
  final DateTime fechaContratacion;

  Mesero(
      {this.id = "",
      required this.nombre,
      required this.apellido,
      required this.estado,
      required this.fechaContratacion,
      this.areaTrabajo = "Meseros",
      required this.celular,
      required this.email,
      required this.imgUrl,
      required this.uuid});

  Mesero.empty()
      : id = "",
        nombre = "",
        apellido = "",
        estado = "",
        areaTrabajo = "Meseros",
        celular = "",
        email = "",
        imgUrl = "",
        uuid = "",
        fechaContratacion = DateTime.now();
}
