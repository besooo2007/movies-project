import 'package:app/features/auth/domin/repositories/auth_repo.dart';



class ResetPassword {
  final AuthRepository repository;

  ResetPassword(this.repository);

  Future<void> call({
    required String email,
  }) {
    return repository.resetPassword(
      email: email,
    );
  }
}