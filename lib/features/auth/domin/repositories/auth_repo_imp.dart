import 'package:app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:app/features/auth/data/models/user_model.dart';
import 'package:app/features/auth/domin/entities/user_entity.dart';
import 'package:app/features/auth/domin/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await remoteDataSource.signIn(
      email: email,
      password: password,
    );

    final user = credential.user!;

    return UserModel.fromFirebase(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoUrl: user.photoURL,
    );
  }

  @override
  Future<UserEntity> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await remoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
    );

    final user = credential.user!;

    return UserModel.fromFirebase(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? name,
      photoUrl: user.photoURL,
    );
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    await remoteDataSource.resetPassword(
      email: email,
    );
  }

  @override
  Future<UserEntity> updateProfile({
    required String name,
    String? photoUrl,
  }) async {
    await remoteDataSource.updateProfile(
      name: name,
      photoUrl: photoUrl,
    );

    final user = remoteDataSource.getCurrentUser()!;

    return UserModel.fromFirebase(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? name,
      photoUrl: user.photoURL,
    );
  }

  @override
  UserEntity? getCurrentUser() {
    final user = remoteDataSource.getCurrentUser();

    if (user == null) {
      return null;
    }

    return UserModel.fromFirebase(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoUrl: user.photoURL,
    );
  }
  @override
Future<void> deleteAccount() async {
  await remoteDataSource.deleteAccount();
}

 @override
Future<UserEntity> signInWithGoogle() async {
  final credential = await remoteDataSource.signInWithGoogle();

  final user = credential.user!;

  return UserModel.fromFirebase(
    id: user.uid,
    email: user.email ?? '',
    name: user.displayName ?? '',
    photoUrl: user.photoURL,
  );
}
}