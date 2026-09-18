import 'dart:convert';
import 'dart:io';
import '../models/movie_model.dart';

abstract class BrowseRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class BrowseRemoteDataSourceImpl implements BrowseRemoteDataSource {
  final HttpClient? client;
  static const String baseUrl = 'https://yts.gg/api/v2/list_movies.json';

  BrowseRemoteDataSourceImpl({this.client});

  @override
  Future<List<MovieModel>> getMovies() async {
    final effectiveClient = client ?? HttpClient();
    final bool isInternalClient = client == null;

    try {
      final request = await effectiveClient.getUrl(Uri.parse(baseUrl));
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        final Map<String, dynamic> data =
            jsonDecode(responseBody) as Map<String, dynamic>;

        if (data['status'] == 'ok' &&
            data['data'] != null &&
            data['data']['movies'] != null) {
          final List moviesJson = data['data']['movies'] as List;
          return moviesJson
              .map((m) => MovieModel.fromJson(m as Map<String, dynamic>))
              .toList();
        }
        return [];
      } else {
        throw HttpException(
          'Failed to load movies. Status code: ${response.statusCode}',
        );
      }
    } finally {
      if (isInternalClient) {
        effectiveClient.close();
      }
    }
  }
}
