import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl
    implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ProfileRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  String get uid {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return user.uid;
  }

  CollectionReference<Map<String, dynamic>>
      get watchListCollection {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('watchList');
  }

  CollectionReference<Map<String, dynamic>>
      get historyCollection {
    return firestore
        .collection('users')
        .doc(uid)
        .collection('history');
  }

  @override
  Future<List<int>> getWatchList() async {
    final snapshot = await watchListCollection.get();

    return snapshot.docs.map((doc) {
      return int.parse(doc.id);
    }).toList();
  }

  @override
  Future<List<int>> getHistory() async {
    final snapshot = await historyCollection.get();

    return snapshot.docs.map((doc) {
      return int.parse(doc.id);
    }).toList();
  }

  @override
  Future<void> addToWatchList({
    required int movieId,
  }) async {
    await watchListCollection
        .doc(movieId.toString())
        .set({
      'movieId': movieId,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> removeFromWatchList({
    required int movieId,
  }) async {
    await watchListCollection
        .doc(movieId.toString())
        .delete();
  }

  @override
  Future<void> addToHistory({
    required int movieId,
  }) async {
    await historyCollection
        .doc(movieId.toString())
        .set({
      'movieId': movieId,
      'watchedAt': FieldValue.serverTimestamp(),
    });
  }
}