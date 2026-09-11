
import 'package:app/features/home_api/data/data%20source/home_remote_data_source.dart';
import 'package:app/features/home_api/domin/entitites/moives_entity.dart';
import 'package:app/features/home_api/domin/repository/home_repo.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MovieEntity>> getMovies() async {
    return await remoteDataSource.getMovies();
  }
}