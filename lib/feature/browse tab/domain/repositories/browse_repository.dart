import '../entities/movie_entity.dart';

abstract class BrowseRepository {
  Future<List<MovieEntity>> getMovies();
}
