

import 'package:app/features/auth/domin/entities/user_entity.dart';
import 'package:app/features/auth/domin/repositories/auth_repo.dart';

class SignIn {
  final AuthRepository repository;

  SignIn(this.repository);

  Future<UserEntity> call({
    required String email,
    required String password,
  }) {
    return repository.signIn(
      email: email,
      password: password,
    );
  }
}