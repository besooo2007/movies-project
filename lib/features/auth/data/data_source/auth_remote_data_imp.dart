import 'package:app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

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

    await firestore.collection('users').doc(credential.user!.uid).set({
      'id': credential.user!.uid,
      'email': email,
      'name': name,
      'phone': '',
      'photoUrl': '',
    });

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

    final userCredential = await firebaseAuth.signInWithCredential(credential);

    final user = userCredential.user!;

    final userDoc = await firestore.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      await firestore.collection('users').doc(user.uid).set({
        'id': user.uid,
        'email': user.email ?? '',
        'name': user.displayName ?? '',
        'phone': user.phoneNumber ?? '',
        'photoUrl': user.photoURL ?? '',
      });
    }

    return userCredential;
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> updateProfile({
    required String name,
    required String phone,
    String? photoUrl,
  }) async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    await user.updateDisplayName(name);

    await firestore.collection('users').doc(user.uid).set({
      'id': user.uid,
      'email': user.email ?? '',
      'name': name,
      'phone': phone,
      'photoUrl': photoUrl ?? '',
    }, SetOptions(merge: true));

    await user.reload();
  }

  @override
  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    final doc = await firestore.collection('users').doc(user.uid).get();

    if (!doc.exists) {
      return null;
    }

    return doc.data();
  }

  @override
  Future<void> deleteAccount() async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    await firestore.collection('users').doc(user.uid).delete();

    await user.delete();
  }

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}
