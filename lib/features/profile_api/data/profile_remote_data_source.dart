import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProfileRemoteDataSource {
  Future<List<int>> getHistory();

  Future<void> addToHistory({
    required int movieId,
  });

  Future<List<int>> getWatchList();

  Future<void> addToWatchList({
    required int movieId,
  });

  Future<void> removeFromWatchList({
    required int movieId,
  });
}

class ProfileRemoteDataSourceImpl
    implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ProfileRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  String get _userId {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    return user.uid;
  }

  DocumentReference<Map<String, dynamic>> get _userDocument =>
      firestore.collection('users').doc(_userId);

  @override
  Future<List<int>> getHistory() async {
    final snapshot = await _userDocument.get();

    final data = snapshot.data();

    if (data == null) {
      return [];
    }

    final history = data['history'];

    if (history == null) {
      return [];
    }

    return List<int>.from(history);
  }

  @override
  Future<void> addToHistory({
    required int movieId,
  }) async {
    await _userDocument.set(
      {
        'history': FieldValue.arrayUnion([movieId]),
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<List<int>> getWatchList() async {
    final snapshot = await _userDocument.get();

    final data = snapshot.data();

    if (data == null) {
      return [];
    }

    final watchList = data['watchList'];

    if (watchList == null) {
      return [];
    }

    return List<int>.from(watchList);
  }

  @override
  Future<void> addToWatchList({
    required int movieId,
  }) async {
    await _userDocument.set(
      {
        'watchList': FieldValue.arrayUnion([movieId]),
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> removeFromWatchList({
    required int movieId,
  }) async {
    await _userDocument.set(
      {
        'watchList': FieldValue.arrayRemove([movieId]),
      },
      SetOptions(merge: true),
    );
  }
}