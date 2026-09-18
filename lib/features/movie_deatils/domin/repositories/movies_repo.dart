import 'package:app/features/movie_deatils/domin/entities/movies_deatils_entites.dart';



abstract class MovieDetailsRepository {

  Future<MovieDetailsEntity> getMovieDetails(
    int movieId,
  );
}