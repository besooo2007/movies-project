import 'package:app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.updateDisplayName(name);

    return credential;
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;

    await googleSignIn.initialize();

    final googleUser = await googleSignIn.authenticate();

    final googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> resetPassword({
    required String email,
  }) async {
    await firebaseAuth.sendPasswordResetEmail(
      email: email,
    );
  }

  @override
  Future<void> updateProfile({
    required String name,
    String? photoUrl,
  }) async {
    final user = firebaseAuth.currentUser;

    await user?.updateDisplayName(name);

    if (photoUrl != null) {
      await user?.updatePhotoURL(photoUrl);
    }

    await user?.reload();
  }

  @override
  Future<void> deleteAccount() async {
    await firebaseAuth.currentUser?.delete();
  }

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}