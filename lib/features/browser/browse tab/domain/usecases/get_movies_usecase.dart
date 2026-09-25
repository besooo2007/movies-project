import '../entities/movie_entity.dart';
import '../repositories/browse_repository.dart';

class GetMoviesUseCase {
  final BrowseRepository repository;

  const GetMoviesUseCase({required this.repository});

  Future<List<MovieEntity>> call() async {
    return await repository.getMovies();
  }
}
