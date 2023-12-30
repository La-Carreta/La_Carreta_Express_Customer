class DetalleOrdenPedido{
  int? id;
  String numOrden;
  String nombre;
  String descripcion;
  String imgUrl;
  int cantidad;
  double precio;
  double valorTotal;

  DetalleOrdenPedido({
    this.id, 
    required this.numOrden, 
    required this.nombre, 
    required this.descripcion, 
    required this.imgUrl, 
    required this.cantidad, 
    required this.precio, 
    required this.valorTotal
  });
}