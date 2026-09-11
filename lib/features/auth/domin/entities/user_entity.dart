class UserEntity {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String? photoUrl;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.photoUrl,
  });
}