

import 'package:app/features/home_api/domin/entitites/moives_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.title,
    required super.titleLong,
    required super.image,
    required super.backgroundImage,
    required super.year,
    required super.rating,
    required super.runtime,
    required super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleLong: json['title_long'] ?? '',
      image: json['medium_cover_image'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(
        json['genres'] ?? [],
      ),
    );
  }
}