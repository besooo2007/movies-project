import 'package:app/features/auth/domin/entities/user_entity.dart';



abstract class AuthRepository {
  Future<UserEntity> signIn({
    required String email,
    required String password,
  });

  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> resetPassword({
    required String email,
  });

  Future<UserEntity> updateProfile({
    required String name,
    String? photoUrl,
  });
  Future<void> deleteAccount();
  Future<UserEntity> signInWithGoogle();

  UserEntity? getCurrentUser();
}