import 'package:app/features/movie_deatils/data/models/movie_details_model.dart';
import 'package:app/features/movie_deatils/data/models/similar_movie_model.dart';
import 'package:dio/dio.dart';

import 'movie_details_remote_data_source.dart';

class MovieDetailsRemoteDataSourceImpl
    implements MovieDetailsRemoteDataSource {
  final Dio dio;

  MovieDetailsRemoteDataSourceImpl(
    this.dio,
  );

  @override
  Future<MovieDetailsModel> getMovieDetails(
    int movieId,
  ) async {
    final response = await dio.get(
      'movie_details.json',
      queryParameters: {
        'movie_id': movieId,
        'with_images': true,
        'with_cast': true,
      },
    );

    print('MOVIE DETAILS RESPONSE:');
    print(response.data);

    final movieJson = response.data['data']['movie'];

    return MovieDetailsModel.fromJson(
      Map<String, dynamic>.from(movieJson),
    );
  }

  @override
  Future<List<SimilarMovieModel>> getSimilarMovies(
    int movieId,
  ) async {
    final response = await dio.get(
      'movie_suggestions.json',
      queryParameters: {
        'movie_id': movieId,
      },
    );

    print('SIMILAR RESPONSE:');
    print(response.data);

    final data = response.data['data'];

    if (data is! Map) {
      return <SimilarMovieModel>[];
    }

    final movies = data['movies'];

    if (movies is! List) {
      return <SimilarMovieModel>[];
    }

    return movies.map<SimilarMovieModel>((movie) {
      return SimilarMovieModel.fromJson(
        Map<String, dynamic>.from(movie),
      );
    }).toList();
  }
}