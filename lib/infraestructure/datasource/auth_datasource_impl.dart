import 'package:la_carreta_express_cs/domain/datasource/auth_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/user.dart';
import 'package:la_carreta_express_cs/infraestructure/errors/auth_errors.dart';
import 'package:la_carreta_express_cs/infraestructure/http/api_client.dart';

class AuthDataSourceImpl extends AuthDatasource {
  final ApiClient _api = ApiClient.instance;

  @override
  Future<User> checkAuthStatus() async {
    if (!await _api.restore()) throw CustomError('Usuario no encontrado');
    return _user(_api.userId!, _api.email ?? '', true);
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      await _api.login(email, password);
      return _user(_api.userId!, email, true);
    } catch (error) {
      throw CustomError(error.toString());
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    try {
      final userId = await _api.register(email, password);
      return User(
        id: userId,
        email: email,
        fullName: fullName,
        imgAvatar: '',
        isActive: false,
        roles: const [],
      );
    } catch (error) {
      throw CustomError(error.toString());
    }
  }

  @override
  Future<bool> logout() async {
    await _api.logout();
    return true;
  }

  @override
  Future<void> resetAccount(String email) async {
    try {
      await _api.request(
        'POST',
        '/auth/password-reset/request',
        body: {'email': email},
        authenticated: false,
      );
    } catch (error) {
      throw CustomError(error.toString());
    }
  }

  @override
  Future<User> updateProfile(
    String fullName,
    String imgUrl,
    String password,
  ) async {
    if (_api.userId == null) throw CustomError('Usuario no encontrado');
    return User(
      id: _api.userId!,
      email: _api.email ?? '',
      fullName: fullName,
      imgAvatar: imgUrl,
      isActive: true,
      roles: const [],
    );
  }

  User _user(String id, String email, bool active) => User(
        id: id,
        email: email,
        fullName: email.split('@').first,
        imgAvatar: '',
        isActive: active,
        roles: const [],
      );
}
