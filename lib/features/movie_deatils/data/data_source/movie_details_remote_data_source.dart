import 'package:app/features/movie_deatils/data/models/movie_details_model.dart';
import 'package:app/features/movie_deatils/data/models/similar_movie_model.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<MovieDetailsModel> getMovieDetails(
    int movieId,
  );

  Future<List<SimilarMovieModel>> getSimilarMovies(
    int movieId,
  );
}