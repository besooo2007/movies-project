import 'package:app/features/movie_deatils/data/models/movie_details_model.dart';
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
      },
    );

    return MovieDetailsModel.fromJson(
      response.data['data']['movie'],
    );
  }
}