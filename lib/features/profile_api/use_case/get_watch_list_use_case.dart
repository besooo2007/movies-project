import 'package:app/features/profile_api/domin/repo/profile_repository.dart';


class GetWatchListUseCase {
  final ProfileRepository repository;

  GetWatchListUseCase({
    required this.repository,
  });

  Future<List<int>> call() {
    return repository.getWatchList();
  }
}