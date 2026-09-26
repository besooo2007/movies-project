import 'package:app/features/home_api/domin/entitites/moives_entity.dart';
import 'package:app/features/search/domin/repo/search_Repository.dart';

class SearchMoviesUseCase {
  final SearchRepository repository;

  SearchMoviesUseCase({
    required this.repository,
  });

  Future<List<MovieEntity>> call({
    required String query,
  }) {
    return repository.searchMovies(
      query: query,
    );
  }
}