final List<String> statusList = [
  'Pedido realizado',
  'Pedido confirmado',
  'Pedido en proceso',
  'Pedido listo',
];

int getCurrentStatusIndex(String status) {
  switch (status) {
    case 'Pedido realizado':
      return 1;
    case 'Pedido confirmado':
      return 2;
    case 'Pedido en proceso':
      return 3;
    case 'Pedido listo':
      return 4;

    default:
      return 0;
  }
}
