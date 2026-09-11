import 'package:app/features/auth/domin/entities/user_entity.dart';
import 'package:app/features/auth/domin/repositories/auth_repo.dart';

class UpdateProfile {
  final AuthRepository repository;

  UpdateProfile(this.repository);

  Future<UserEntity> call({
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