import 'package:app/features/movie_deatils/domin/entities/similar_movie_entity.dart';
import 'package:app/features/movie_deatils/domin/repositories/movies_repo.dart';

class GetSimilarMovies {
  final MovieDetailsRepository repository;

  GetSimilarMovies(
    this.repository,
  );

  Future<List<SimilarMovieEntity>> call(
    int movieId,
  ) async {
    return await repository.getSimilarMovies(
      movieId,
    );
  }
}