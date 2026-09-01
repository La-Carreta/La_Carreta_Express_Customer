import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/presentation/providers/customer/customer_repository_provider.dart';

final customerProvider =
    StateNotifierProvider<CustomerNotifier, Cliente>((ref) {
  final getCustomer = ref.watch(clienteRepositoryProvider).getCustomer;
  final updateCustomer = ref.watch(clienteRepositoryProvider).updateCustomer;
  final createCustomer = ref.watch(clienteRepositoryProvider).createCustomer;

  return CustomerNotifier(
      getCustomer: getCustomer,
      updateCustomer: updateCustomer,
      createCustomer: createCustomer);
});

typedef CustomerCallBack = Future<Cliente> Function(
    {required String idCliente});
typedef UpdateCustomerCallBack = Future<Cliente> Function(
    {required Cliente cliente});
typedef CreateCustomerCallBack = Future<Cliente> Function(
    {required Cliente cliente, required String uuid});

class CustomerNotifier extends StateNotifier<Cliente> {
  final CustomerCallBack getCustomer;
  final CreateCustomerCallBack createCustomer;
  final UpdateCustomerCallBack updateCustomer;
  bool isLoading = false;

  CustomerNotifier(
      {required this.getCustomer,
      required this.updateCustomer,
      required this.createCustomer})
      : super(Cliente.empty());

  Future<void> getCustomerById(String idCliente) async {
    if (isLoading) return;
    isLoading = true;

    final customer = await getCustomer(idCliente: idCliente);

    state = state.copyWith(
        id: customer.id,
        nombre: customer.nombre,
        apellido: customer.apellido,
        correo: customer.correo,
        direccion: customer.direccion,
        celular: customer.celular,
        imgUrl: customer.imgUrl,
        uuid: customer.uuid);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> updateCustomerData(Cliente customer) async {
    if (isLoading) return;
    isLoading = true;

    final customerUpdated = await updateCustomer(cliente: customer);

    state = state.copyWith(
        id: customerUpdated.id,
        nombre: customerUpdated.nombre,
        apellido: customerUpdated.apellido,
        correo: customerUpdated.correo,
        direccion: customerUpdated.direccion,
        celular: customerUpdated.celular,
        imgUrl: customerUpdated.imgUrl,
        uuid: customerUpdated.uuid);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

  Future<void> createCustomerData(Cliente customer, String uuid) async {
    if (isLoading) return;
    isLoading = true;

    final customerCreated = await createCustomer(cliente: customer, uuid: uuid);

    state = state.copyWith(
        id: uuid,
        nombre: customerCreated.nombre,
        apellido: customerCreated.apellido,
        correo: customerCreated.correo,
        direccion: customerCreated.direccion,
        celular: customerCreated.celular,
        imgUrl: customerCreated.imgUrl,
        uuid: uuid);

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
