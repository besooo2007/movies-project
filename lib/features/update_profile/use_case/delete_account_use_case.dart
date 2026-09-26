import 'package:app/features/update_profile/domin/repo/update_profile_repository.dart';


class DeleteAccountUseCase {
  final UpdateProfileRepository repository;

  DeleteAccountUseCase({
    required this.repository,
  });

  Future<void> call() {
    return repository.deleteAccount();
  }
}