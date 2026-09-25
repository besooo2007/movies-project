import 'package:app/feature/browse%20tab/data/models/movie_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieModel tests', () {
    test('fromJson correctly parses full JSON map', () {
      final json = {
        'id': 78601,
        'title': 'Rage of Stars',
        'title_english': 'Rage of Stars',
        'year': 2026,
        'rating': 4.7,
        'runtime': 98,
        'genres': ['Action', 'Sci-Fi', 'Thriller'],
        'summary': 'An outstanding policewoman...',
        'medium_cover_image': 'https://example.com/medium.jpg',
        'large_cover_image': 'https://example.com/large.jpg',
      };

      final movie = MovieModel.fromJson(json);

      expect(movie.id, 78601);
      expect(movie.title, 'Rage of Stars');
      expect(movie.titleEnglish, 'Rage of Stars');
      expect(movie.year, 2026);
      expect(movie.rating, 4.7);
      expect(movie.runtime, 98);
      expect(movie.genres, ['Action', 'Sci-Fi', 'Thriller']);
      expect(movie.summary, 'An outstanding policewoman...');
      expect(movie.mediumCoverImage, 'https://example.com/medium.jpg');
      expect(movie.largeCoverImage, 'https://example.com/large.jpg');
    });

    test('fromJson handles null / missing values gracefully without crashing', () {
      final json = <String, dynamic>{};

      final movie = MovieModel.fromJson(json);

      expect(movie.id, 0);
      expect(movie.title, '');
      expect(movie.titleEnglish, '');
      expect(movie.year, 0);
      expect(movie.rating, 0.0);
      expect(movie.runtime, 0);
      expect(movie.genres, isEmpty);
      expect(movie.summary, '');
      expect(movie.mediumCoverImage, '');
      expect(movie.largeCoverImage, '');
    });

    test('toJson serializes model correctly', () {
      const movie = MovieModel(
        id: 100,
        title: 'Test Movie',
        titleEnglish: 'Test Movie English',
        year: 2025,
        rating: 9.1,
        runtime: 140,
        genres: ['Drama', 'Mystery'],
        summary: 'A thrilling drama',
        mediumCoverImage: 'https://example.com/m.jpg',
        largeCoverImage: 'https://example.com/l.jpg',
      );

      final json = movie.toJson();

      expect(json['id'], 100);
      expect(json['title'], 'Test Movie');
      expect(json['rating'], 9.1);
      expect(json['genres'], ['Drama', 'Mystery']);
    });
  });
}
