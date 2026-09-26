import 'package:app/features/home_api/data/models/movies_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<MovieModel>> searchMovies({
    required String query,
  });
}