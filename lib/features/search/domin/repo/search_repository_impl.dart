import 'package:app/features/home_api/domin/entitites/moives_entity.dart';
import 'package:app/features/search/data/search_remote_data_source.dart';
import 'package:app/features/search/domin/repo/search_Repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<MovieEntity>> searchMovies({
    required String query,
  }) async {
    final movies = await remoteDataSource.searchMovies(
      query: query,
    );

    return List<MovieEntity>.from(movies);
  }
}