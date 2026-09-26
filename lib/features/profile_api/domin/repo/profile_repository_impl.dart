import 'package:app/features/profile_api/data/profile_remote_data_source.dart';
import 'package:app/features/profile_api/domin/repo/profile_repository.dart';

class ProfileRepositoryImpl
    implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<int>> getHistory() {
    return remoteDataSource.getHistory();
  }

  @override
  Future<void> addToHistory({
    required int movieId,
  }) {
    return remoteDataSource.addToHistory(
      movieId: movieId,
    );
  }

  @override
  Future<List<int>> getWatchList() {
    return remoteDataSource.getWatchList();
  }

  @override
  Future<void> addToWatchList({
    required int movieId,
  }) {
    return remoteDataSource.addToWatchList(
      movieId: movieId,
    );
  }

  @override
  Future<void> removeFromWatchList({
    required int movieId,
  }) {
    return remoteDataSource.removeFromWatchList(
      movieId: movieId,
    );
  }
}