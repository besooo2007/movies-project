import 'dart:convert';

import 'package:app/features/home_api/data/data source/app_constant.dart';
import 'package:app/features/home_api/data/data source/home_remote_data_source.dart';
import 'package:app/features/home_api/data/models/movies_model.dart';
import 'package:http/http.dart' as http;

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<MovieModel>> getMovies() async {
    final List<MovieModel> allMovies = [];

    for (int page = 1; page <= 5; page++) {
      final response = await http.get(
        Uri.parse('${ApiConstants.listMovies}?page=$page&limit=20'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final movies = data['data']['movies'] as List;

        allMovies.addAll(
          movies.map((movie) => MovieModel.fromJson(movie)).toList(),
        );
      } else {
        throw Exception('Failed to get movies');
      }
    }

    return allMovies;
  }
}