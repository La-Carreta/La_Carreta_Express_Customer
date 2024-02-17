class Categoria{
  final String id;
  final String nombre;
  final String imgUrl;

  Categoria({
    this.id = "", 
    required this.nombre, 
    required this.imgUrl
  });

  Categoria.empty() :
    id = "",
    nombre = "",
    imgUrl = "";
}
