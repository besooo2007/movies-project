import 'package:app/features/profile_api/domin/repo/profile_repository.dart';


class RemoveFromWatchListUseCase {
  final ProfileRepository repository;

  RemoveFromWatchListUseCase({
    required this.repository,
  });

  Future<void> call({
    required int movieId,
  }) {
    return repository.removeFromWatchList(
      movieId: movieId,
    );
  }
}