class User {
  final String id;
  final String email;
  final String fullName;
  final String imgAvatar;
  final bool isActive;
  final List<String> roles;

  User(
      {required this.id,
      required this.email,
      required this.fullName,
      required this.imgAvatar,
      required this.isActive,
      required this.roles});

  bool get isAdmin => roles.contains('admin');
}
