import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:la_carreta_express_cs/domain/entities/cliente.dart';
import 'package:la_carreta_express_cs/presentation/providers/auth/auth_provider.dart';
import 'package:la_carreta_express_cs/presentation/providers/customer/customer_provider.dart';
import 'package:la_carreta_express_cs/shared/infraestructure/inputs/inputs.dart';


//! 3 - StateNotifierProvider - consume afuera
final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>((ref){

  final registerUserCallbackFirebase = ref.watch(authProvider.notifier).registerUser;
  final registerCustomerCallbackFirebase = ref.watch(customerProvider.notifier).createCustomerData;

  return RegisterFormNotifier(
    registerUserCallbackFirebase: registerUserCallbackFirebase,
    registerCustomerCallbackFirebase: registerCustomerCallbackFirebase
  );
});

//! 1 - State de este provider
class RegisterFormState{

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final Name name;
  final LastName lastName;
  final PhoneNumber phoneNumber;
  final Address address;

  RegisterFormState({
    this.isPosting = false, 
    this.isFormPosted = false, 
    this.isValid = false, 
    this.email = const Email.pure(), 
    this.password = const Password.pure(),
    this.name = const Name.pure(),
    this.lastName = const LastName.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.address = const Address.pure()    
  });


  @override
  String toString() { 
    return '''
      RegisterFormState(
        isPosting: $isPosting, 
        isFormPosted: $isFormPosted, 
        isValid: $isValid, 
        email: $email, 
        password: $password)
    ''';
  }

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    Name? name,
    LastName? lastName,
    PhoneNumber? phoneNumber,
    Address? address    
  }){
    return RegisterFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address      
    );
  }
}

//! 2 - Como implementamos un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallbackFirebase;
  final Function(Cliente, String) registerCustomerCallbackFirebase;

  RegisterFormNotifier({
    required this.registerUserCallbackFirebase,
    required this.registerCustomerCallbackFirebase
  }): super( RegisterFormState());
  
  onEmailChanged(String value){
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail, 
      isValid: Formz.validate([
        newEmail, 
        state.password, 
        state.name, 
        state.lastName, 
        state.phoneNumber, 
        state.address
      ])
    );
  }

  onPasswordChanged(String value){
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([
        state.email, 
        newPassword, 
        state.name, 
        state.lastName, 
        state.phoneNumber, 
        state.address
      ])
    );
  }

  onNameChanged(String value){
    final newName = Name.dirty(value);
    state = state.copyWith(
      name: newName,
      isValid: Formz.validate([
        newName, 
        state.lastName, 
        state.phoneNumber, 
        state.address, 
        state.email, 
        state.password
      ])
    );
  }

  onLastNameChanged(String value){
    final newLastName = LastName.dirty(value);
    state = state.copyWith(
      lastName: newLastName,
      isValid: Formz.validate([
        state.name, 
        newLastName, 
        state.phoneNumber, 
        state.address, 
        state.email, 
        state.password
      ])
    );
  }

  onPhoneNumberChanged(String value){
    final newPhoneNumber = PhoneNumber.dirty(value);
    state = state.copyWith(
      phoneNumber: newPhoneNumber,
      isValid: Formz.validate([
        state.name, 
        state.lastName, 
        newPhoneNumber, 
        state.address, 
        state.email, 
        state.password
      ])
    );
  }

  onAddressChanged(String value){
    final newAddress = Address.dirty(value);
    state = state.copyWith(
      address: newAddress,
      isValid: Formz.validate([
        state.name, 
        state.lastName, 
        state.phoneNumber, 
        newAddress, 
        state.email, 
        state.password
      ])
    );
  }

  onFormSubmit() async{
    _touchEveryField();

    if(!state.isValid) return;

    state = state.copyWith(isPosting: true);
    final fullName = '${state.name.value} ${state.lastName.value}';

    final String resp = await registerUserCallbackFirebase(state.email.value, state.password.value, fullName);
    state = state.copyWith(isPosting: false);
    
    final Cliente cliente = Cliente(
      id: resp,
      nombre: state.name.value,
      apellido: state.lastName.value,
      correo: state.email.value,
      direccion: state.address.value,
      celular: state.phoneNumber.value,
      uuid: resp,
      imgUrl: 'https://res.cloudinary.com/dwexseytn/image/upload/v1708297546/La_Carreta_Express/Avatar_users/no-profile-photo_nsgx2g.png',
    );

    await registerCustomerCallbackFirebase( cliente, resp );

  
    await Future.delayed(const Duration(milliseconds: 300));
  }

  _touchEveryField(){
    state = state.copyWith(
      email: Email.dirty(state.email.value),
      password: Password.dirty(state.password.value),
      name: Name.dirty(state.name.value),
      lastName: LastName.dirty(state.lastName.value),
      phoneNumber: PhoneNumber.dirty(state.phoneNumber.value),
      address: Address.dirty(state.address.value),      
      isFormPosted: true,
      isValid: Formz.validate([
        state.email, 
        state.password, 
        state.name, 
        state.lastName, 
        state.phoneNumber, 
        state.address
      ])
    );
  }

} 


