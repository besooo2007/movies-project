import 'package:app/features/movie_deatils/domin/entities/movies_deatils_entites.dart';
import 'package:app/features/movie_deatils/domin/entities/similar_movie_entity.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetailsEntity> getMovieDetails(
    int movieId,
  );

  Future<List<SimilarMovieEntity>> getSimilarMovies(
    int movieId,
  );
}