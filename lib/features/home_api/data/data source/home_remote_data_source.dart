import 'package:app/features/home_api/data/models/movies_model.dart';


abstract class HomeRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}