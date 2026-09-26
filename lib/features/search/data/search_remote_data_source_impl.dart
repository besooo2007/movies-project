import 'package:app/features/home_api/data/models/movies_model.dart';
import 'package:dio/dio.dart';

import 'search_remote_data_source.dart';

class SearchRemoteDataSourceImpl
    implements SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<List<MovieModel>> searchMovies({
    required String query,
  }) async {
    final response = await dio.get(
      'list_movies.json',
      queryParameters: {
        'query_term': query,
        'limit': 20,
      },
    );

    final moviesData = response.data['data']?['movies'];

    if (moviesData == null) {
      return [];
    }

    return (moviesData as List)
        .map(
          (movie) => MovieModel.fromJson(
            movie as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}