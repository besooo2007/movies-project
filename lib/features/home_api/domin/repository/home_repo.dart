
import 'package:app/features/home_api/domin/entitites/moives_entity.dart';

abstract class HomeRepository {
  Future<List<MovieEntity>> getMovies();
}