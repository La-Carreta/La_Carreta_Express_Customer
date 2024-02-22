import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:la_carreta_express_cs/domain/entities/user.dart';

class UserMapper{
  static userJsonToEntity(Map<String, dynamic> json) => User(
    id: json['id'],
    fullName: json['fullName'],
    email: json['email'], 
    isActive: json['isActive'],
    imgAvatar: json['imgAvatar'],
    roles: List<String>.from(json['roles'].map((role)=>role)), 
  );

  static userToEntity(auth.User userFirebase) => User(
    id: userFirebase.uid, 
    email: userFirebase.email!, 
    fullName: userFirebase.displayName ?? "No name", 
    imgAvatar: userFirebase.photoURL ?? "No photo", 
    isActive: userFirebase.emailVerified, 
    roles: []
  );
}