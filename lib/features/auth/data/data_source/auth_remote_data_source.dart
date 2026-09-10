import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signIn({
    required String email,
    required String password,
  });

  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserCredential> signInWithGoogle();

  Future<void> resetPassword({
    required String email,
  });

  Future<void> updateProfile({
    required String name,
    String? photoUrl,
  });

  Future<void> deleteAccount();

  User? getCurrentUser();
}