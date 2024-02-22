import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:la_carreta_express_cs/domain/entities/user.dart';
import 'package:la_carreta_express_cs/domain/repositories/auth_repository.dart';
import 'package:la_carreta_express_cs/infraestructure/errors/auth_errors.dart';
import 'package:la_carreta_express_cs/infraestructure/repositories/auth_repository_imp.dart';

//! 3 - StateNotifierProvider - consume afuera
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImp();

  return AuthNotifier(
    authRepository: authRepository,
  );
});

//! 2 - Como implementamos un notifier
class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;

  AuthNotifier({
    required this.authRepository,
  }): super(AuthState()){
    checkAuthStatus();
  }
  
  void checkAuthStatus() async{
    try {
      final user = await authRepository.checkAuthStatus();      
      _setLoggedUser(user);    
    } catch (e) {
      logout();
    }
  }

  Future<void> loginUser(String email, String password) async{
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser( user );      
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }

    state = state.copyWith(authStatus: AuthStatus.checking);
  }

  Future<void> updateProfile(String fullName, String imgUrl, String password) async{
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      await authRepository.updateProfile(fullName, imgUrl, password);    
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  Future<void> logout([String? errorMessage]) async{
    await authRepository.logout();
    
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage ?? ''
    );
  }

  Future<String?> registerUser(String email, String password, String fullName) async{
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.register(email, password, fullName);
      _setLoggedUser(user);      
      return user.id;
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }

    state = state.copyWith(authStatus: AuthStatus.checking);
    return null;
  }

  void _setLoggedUser(User user) async{

    await Future.delayed(const Duration(milliseconds: 500));

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: ''
    );
  }

  Future<void> resetAccount(String email, [String? errorMessage]) async{
    await Future.delayed(const Duration(milliseconds: 500));
    await authRepository.resetAccount(email);
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage ?? ''
    );
  }


}


enum AuthStatus{
  checking,
  authenticated,
  notAuthenticated,
}
//! 1 - State de este provider
class AuthState{
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = ''
  }); 

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage
  }){
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

}