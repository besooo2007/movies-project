import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/browse_repository.dart';
import '../datasources/browse_remote_data_source.dart';

class BrowseRepositoryImpl implements BrowseRepository {
  final BrowseRemoteDataSource remoteDataSource;

  const BrowseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MovieEntity>> getMovies() async {
    return await remoteDataSource.getMovies();
  }
}
