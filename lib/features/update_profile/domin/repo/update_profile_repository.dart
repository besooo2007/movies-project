abstract class UpdateProfileRepository {


  Future<void> updateProfile({
    required String name,
    required String phone,
    String? photoUrl,
  });


  Future<void> deleteAccount();
}