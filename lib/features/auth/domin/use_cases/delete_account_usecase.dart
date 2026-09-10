import 'package:app/features/auth/domin/repositories/auth_repo.dart';

class DeleteAccount {
  final AuthRepository repository;

  DeleteAccount(this.repository);

  Future<void> call() async {
    await repository.deleteAccount();
  }
}