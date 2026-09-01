# La Carreta Express — Cliente

App Flutter conectada exclusivamente a NestJS/PostgreSQL para Auth, catálogo,
pedido, seguimiento y notificaciones in-app. El carrito local es sólo un borrador;
precios, impuestos, totales y estados los decide el backend.

```bash
flutter run \
  --dart-define=API_BASE_URL=http://10.0.2.2:3000/api/v1 \
  --dart-define=TENANT_ID=<uuid> \
  --dart-define=BRANCH_ID=<uuid> \
  --dart-define=TABLE_ID=<uuid>
```

`TABLE_ID` es una configuración temporal para el piloto. Antes de producción debe
resolverse mediante QR/deep link firmado para no generar una build por mesa.

Validación: `flutter analyze`. Firebase ya no forma parte de esta aplicación.
