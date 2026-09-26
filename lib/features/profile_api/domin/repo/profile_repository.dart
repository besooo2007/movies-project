abstract class ProfileRepository {
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