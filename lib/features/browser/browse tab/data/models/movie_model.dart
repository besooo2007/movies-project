import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.titleEnglish,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.genres,
    required super.summary,
    required super.mediumCoverImage,
    required super.largeCoverImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final rawGenres = json['genres'];
    final List<String> parsedGenres = [];
    if (rawGenres is List) {
      for (final item in rawGenres) {
        if (item != null) {
          final str = item.toString().trim();
          if (str.isNotEmpty) {
            parsedGenres.add(str);
          }
        }
      }
    }

    return MovieModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] as String? ?? '',
      titleEnglish: json['title_english'] as String? ?? '',
      year: json['year'] is int
          ? json['year'] as int
          : int.tryParse(json['year']?.toString() ?? '0') ?? 0,
      rating: json['rating'] is num
          ? (json['rating'] as num).toDouble()
          : double.tryParse(json['rating']?.toString() ?? '0.0') ?? 0.0,
      runtime: json['runtime'] is int
          ? json['runtime'] as int
          : int.tryParse(json['runtime']?.toString() ?? '0') ?? 0,
      genres: parsedGenres,
      summary: json['summary'] as String? ?? '',
      mediumCoverImage: json['medium_cover_image'] as String? ?? '',
      largeCoverImage: json['large_cover_image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'title_english': titleEnglish,
      'year': year,
      'rating': rating,
      'runtime': runtime,
      'genres': genres,
      'summary': summary,
      'medium_cover_image': mediumCoverImage,
      'large_cover_image': largeCoverImage,
    };
  }
}
