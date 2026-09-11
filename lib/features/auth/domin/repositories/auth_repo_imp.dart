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

    final profile = await remoteDataSource.getUserProfile();

    return UserModel.fromFirebase(
      id: user.uid,
      email: user.email ?? '',
      name: profile?['name'] ?? user.displayName ?? '',
      phone: profile?['phone'] ?? '',
      photoUrl: profile?['photoUrl'],
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
      name: name,
      phone: '',
      photoUrl: '',
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
    required String phone,
    String? photoUrl,
  }) async {
    await remoteDataSource.updateProfile(
      name: name,
      phone: phone,
      photoUrl: photoUrl,
    );

    final user = remoteDataSource.getCurrentUser()!;

    return UserModel.fromFirebase(
      id: user.uid,
      email: user.email ?? '',
      name: name,
      phone: phone,
      photoUrl: photoUrl,
    );
  }

  @override
  Future<UserEntity?> getUserProfile() async {
    final user = remoteDataSource.getCurrentUser();

    if (user == null) {
      return null;
    }

    final profile = await remoteDataSource.getUserProfile();

    if (profile == null) {
      return null;
    }

    return UserModel.fromFirebase(
      id: user.uid,
      email: user.email ?? '',
      name: profile['name'] ?? '',
      phone: profile['phone'] ?? '',
      photoUrl: profile['photoUrl'],
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
      phone: user.phoneNumber ?? '',
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

    final profile = await remoteDataSource.getUserProfile();

    return UserModel.fromFirebase(
      id: user.uid,
      email: user.email ?? '',
      name: profile?['name'] ?? user.displayName ?? '',
      phone: profile?['phone'] ?? '',
      photoUrl: profile?['photoUrl'] ?? user.photoURL,
    );
  }
}