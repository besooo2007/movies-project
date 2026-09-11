import 'package:app/features/auth/domin/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.phone,
    super.photoUrl,
  });

  factory UserModel.fromFirebase({
    required String id,
    required String email,
    required String name,
    required String phone,
    String? photoUrl,
  }) {
    return UserModel(
      id: id,
      email: email,
      name: name,
      phone: phone,
      photoUrl: photoUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      photoUrl: json['photoUrl'],
    );
  }
}