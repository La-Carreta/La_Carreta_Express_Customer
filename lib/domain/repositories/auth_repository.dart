import 'package:la_carreta_express_cs/domain/entities/user.dart';

abstract class AuthRepository{
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String fullName);
  Future<User> checkAuthStatus();
  Future<bool> logout();
}