import 'package:app/features/profile_api/domin/repo/profile_repository.dart';


class AddToHistoryUseCase {
  final ProfileRepository repository;

  AddToHistoryUseCase({
    required this.repository,
  });

  Future<void> call({
    required int movieId,
  }) {
    return repository.addToHistory(
      movieId: movieId,
    );
  }
}