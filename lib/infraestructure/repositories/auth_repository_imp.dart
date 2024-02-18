
import 'package:la_carreta_express_cs/domain/datasource/auth_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/user.dart';
import 'package:la_carreta_express_cs/domain/repositories/auth_repository.dart';
import 'package:la_carreta_express_cs/infraestructure/datasource/auth_datasource_impl.dart';

class AuthRepositoryImp extends AuthRepository{

  final AuthDatasource datasource;

  AuthRepositoryImp(
    [AuthDatasource? datasource]
  ): datasource = datasource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus() {
    return datasource.checkAuthStatus();
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return datasource.register(email, password, fullName);
  }
  
  @override
  Future<bool> logout() {
    return datasource.logout();
  }

}