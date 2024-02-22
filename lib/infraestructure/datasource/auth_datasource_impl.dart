import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:la_carreta_express_cs/domain/datasource/auth_datasource.dart';
import 'package:la_carreta_express_cs/domain/entities/user.dart';
import 'package:la_carreta_express_cs/infraestructure/errors/auth_errors.dart';
import 'package:la_carreta_express_cs/infraestructure/mappers/user_mapper.dart';

class AuthDataSourceImpl extends AuthDatasource{
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  @override
  Future<User> checkAuthStatus() async{
    try {
      //Check if user is logged in
      final user = _firebaseAuth.currentUser;
      if(user == null) throw CustomError("Usuario no encontrado");
      final userFound = UserMapper.userToEntity(user);

      return userFound;
    } on auth.FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found') throw CustomError("Usuario no encontrado");
      if(e.code == 'wrong-password') throw CustomError("Contraseña incorrecta");
      if(e.code == 'invalid-email') throw CustomError("Correo inválido");
      if(e.code == 'user-disabled') throw CustomError("Usuario deshabilitado");
      if(e.code == 'too-many-requests') throw CustomError("Demasiados intentos, intente más tarde");
      if(e.code == 'operation-not-allowed') throw CustomError("Operación no permitida");
      if(e.code == 'email-already-in-use') throw CustomError("Correo ya en uso");
      if(e.code == 'weak-password') throw CustomError("Contraseña débil");
      if(e.code == 'invalid-credential') throw CustomError("Credenciales inválidas");
      if(e.code == 'invalid-verification-code') throw CustomError("Código de verificación inválido");
      if(e.code == 'invalid-verification-id') throw CustomError("Id de verificación inválido");    
      throw Exception();      
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  @override
  Future<User> login(String email, String password) async{
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if(user == null) throw CustomError("Usuario no encontrado");      

      return UserMapper.userToEntity(user);      
    }on auth.FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found') throw CustomError("Usuario no encontrado");
      if(e.code == 'wrong-password') throw CustomError("Contraseña incorrecta");
      if(e.code == 'invalid-email') throw CustomError("Correo inválido");
      if(e.code == 'user-disabled') throw CustomError("Usuario deshabilitado");
      if(e.code == 'too-many-requests') throw CustomError("Demasiados intentos, intente más tarde");
      if(e.code == 'operation-not-allowed') throw CustomError("Operación no permitida");
      if(e.code == 'email-already-in-use') throw CustomError("Correo ya en uso");
      if(e.code == 'weak-password') throw CustomError("Contraseña débil");
      if(e.code == 'invalid-credential') throw CustomError("Credenciales inválidas");
      if(e.code == 'invalid-verification-code') throw CustomError("Código de verificación inválido");
      if(e.code == 'invalid-verification-id') throw CustomError("Id de verificación inválido");    
      throw Exception();      
    } catch (e) {
      throw CustomError(e.toString());
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async{
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if(user == null) throw CustomError("Usuario no encontrado");      

      return UserMapper.userToEntity(user);
    } on auth.FirebaseAuthException catch (e) {
      if(e.code == 'invalid-email') throw CustomError("Correo inválido");
      if(e.code == 'email-already-in-use') throw CustomError("Correo ya en uso");      
      throw Exception();      
    } catch (e) {
      throw CustomError(e.toString());
    }
  }
  
  @override
  Future<bool> logout() async{
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<void> resetAccount(String email) async{
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw CustomError(e.toString());
    }
  }
  
  @override
  Future<User> updateProfile(String fullName, String imgUrl, String password) async{
    try {
      final user = _firebaseAuth.currentUser;
      if(user == null) throw CustomError("Usuario no encontrado");
      user.updateDisplayName(fullName);
      user.updatePhotoURL(imgUrl);
      user.updatePassword(password);
      
      return UserMapper.userToEntity(user);      
    } catch (e) {
      throw CustomError(e.toString());
    }
  }
} 