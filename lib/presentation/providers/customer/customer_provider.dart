import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/presentation/providers/customer/customer_repository_provider.dart';

final customerProvider = StateNotifierProvider<CustomerNotifier, Cliente>((ref){
  final getCustomer = ref.watch( clienteRepositoryProvider ).getCustomer;
  final updateCustomer = ref.watch( clienteRepositoryProvider ).updateCustomer;

  return CustomerNotifier(
    getCustomer: getCustomer,
    updateCustomer: updateCustomer
  );
});

typedef CustomerCallBack = Future<Cliente> Function({required String idCliente});
typedef UpdateCustomerCallBack = Future<Cliente> Function({required Cliente cliente});

class CustomerNotifier extends StateNotifier<Cliente>{
  
  final CustomerCallBack getCustomer;
  final UpdateCustomerCallBack updateCustomer;
  bool isLoading = false;
  CustomerNotifier({
    required this.getCustomer,
    required this.updateCustomer
  }):super(Cliente.empty());


  Future<void> getCustomerById(String idCliente) async{
    if(isLoading) return;
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
      uuid: customer.uuid
    );

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

}