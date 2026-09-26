import 'package:app/features/home_api/domin/entitites/moives_entity.dart';

abstract class SearchRepository {
  Future<List<MovieEntity>> searchMovies({
    required String query,
  });
}