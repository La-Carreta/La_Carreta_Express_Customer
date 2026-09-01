import 'package:la_carreta_express_cs/domain/entities/user.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
        id: json['id']?.toString() ?? '',
        fullName: json['fullName']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        isActive: json['isActive'] == true,
        imgAvatar: json['imgAvatar']?.toString() ?? '',
        roles: List<String>.from(json['roles'] as List? ?? const []),
      );
}
