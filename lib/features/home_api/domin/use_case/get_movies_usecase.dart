
import 'package:app/features/home_api/domin/entitites/moives_entity.dart';
import 'package:app/features/home_api/domin/repository/home_repo.dart';

class GetMovies {
  final HomeRepository repository;

  GetMovies(this.repository);

  Future<List<MovieEntity>> call() async {
    return await repository.getMovies();
  }
}