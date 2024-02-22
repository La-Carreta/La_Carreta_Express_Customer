final List<String> statusList = [
  'Pedido realizado',
  'Pedido confirmado',
  'Pedido en preparación',
  'Pedido listo',
];

int getCurrentStatusIndex(String status) {
  switch (status) {
    case 'Pedido realizado':
      return 1;
    case 'Pedido confirmado':
      return 2;
    case 'Pedido en preparación':
      return 3;
    case 'Pedido listo':
      return 4;

    default:
      return 0;
  }
}
