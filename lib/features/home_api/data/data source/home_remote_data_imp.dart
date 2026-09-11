import 'dart:convert';

import 'package:app/features/home_api/data/data%20source/app_constant.dart';
import 'package:app/features/home_api/data/data%20source/home_remote_data_source.dart';
import 'package:app/features/home_api/data/models/movies_model.dart';
import 'package:http/http.dart' as http;

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await http.get(Uri.parse(ApiConstants.listMovies));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final movies = data['data']['movies'] as List;

      return movies.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to get movies');
    }
  }
}
