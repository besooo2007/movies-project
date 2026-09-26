abstract class UpdateProfileRemoteDataSource {


  Future<void> updateProfile({
    required String name,
    required String phone,
  });



  Future<void> deleteAccount();
}