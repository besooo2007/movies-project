import 'package:app/features/update_profile/domin/repo/update_profile_repository.dart';

class UpdateProfileUseCase {
  final UpdateProfileRepository repository;

  UpdateProfileUseCase({
    required this.repository,
  });

  Future<void> call({
    required String name,
    required String phone,
    String? photoUrl,
  }) {
    return repository.updateProfile(
      name: name,
      phone: phone,
      photoUrl: photoUrl,
    );
  }
}