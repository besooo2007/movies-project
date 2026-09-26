import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'update_profile_remote_data_source.dart';

class UpdateProfileRemoteDataSourceImpl
    implements UpdateProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  UpdateProfileRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });



  User get _currentUser {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return user;
  }

 

  @override
  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    final user = _currentUser;

  
    await firestore.collection('users').doc(user.uid).set(
      {
        'name': name,
        'phone': phone,
      },
      SetOptions(merge: true),
    );

  
    await user.updateDisplayName(name);
  }


  @override
  Future<void> deleteAccount() async {
    final user = _currentUser;

    await firestore.collection('users').doc(user.uid).delete();


    await user.delete();
  }
}