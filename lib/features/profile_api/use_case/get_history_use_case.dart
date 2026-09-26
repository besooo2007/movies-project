import 'package:app/features/profile_api/domin/repo/profile_repository.dart';


class GetHistoryUseCase {
  final ProfileRepository repository;

  GetHistoryUseCase({
    required this.repository,
  });

  Future<List<int>> call() {
    return repository.getHistory();
  }
}