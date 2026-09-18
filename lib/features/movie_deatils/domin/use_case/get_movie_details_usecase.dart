import 'package:app/features/movie_deatils/domin/entities/movies_deatils_entites.dart';
import 'package:app/features/movie_deatils/domin/repositories/movies_repo.dart';

class GetMovieDetails {
  final MovieDetailsRepository repository;

  GetMovieDetails(this.repository);

  Future<MovieDetailsEntity> call(int movieId) async {
    return await repository.getMovieDetails(movieId);
  }
}