import 'package:app/features/movie_deatils/data/data_source/movie_details_remote_data_source.dart';
import 'package:app/features/movie_deatils/data/models/movie_details_model.dart';

class GetSavedMoviesUseCase {
  final MovieDetailsRemoteDataSource remoteDataSource;

  GetSavedMoviesUseCase({
    required this.remoteDataSource,
  });

  Future<List<MovieDetailsModel>> call({
    required List<int> movieIds,
  }) async {
    final List<MovieDetailsModel> movies = [];

    for (final movieId in movieIds) {
      try {
        final movie = await remoteDataSource.getMovieDetails(movieId);
        movies.add(movie);
      } catch (e) {
        continue;
      }
    }

    return movies;
  }
}