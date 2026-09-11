import 'package:app/features/auth/domin/entities/user_entity.dart';
import 'package:app/features/auth/domin/repositories/auth_repo.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<UserEntity> call() async {
    return await repository.signInWithGoogle();
  }
}