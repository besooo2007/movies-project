import 'package:app/features/profile_api/domin/repo/profile_repository.dart';


class AddToWatchListUseCase {
  final ProfileRepository repository;

  AddToWatchListUseCase({
    required this.repository,
  });

  Future<void> call({
    required int movieId,
  }) {
    return repository.addToWatchList(
      movieId: movieId,
    );
  }
}