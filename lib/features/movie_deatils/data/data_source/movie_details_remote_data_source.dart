import 'package:app/features/movie_deatils/data/models/movie_details_model.dart';



abstract class MovieDetailsRemoteDataSource {
  Future<MovieDetailsModel> getMovieDetails(
    int movieId,
  );
}