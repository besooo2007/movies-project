

import 'package:app/features/auth/data/user_entity.dart';
import 'package:app/features/auth/domin/repositories/auth_repo.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.signUp(
      name: name,
      email: email,
      password: password,
    );
  }
}