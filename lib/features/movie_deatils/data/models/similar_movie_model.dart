import 'package:app/features/movie_deatils/domin/entities/similar_movie_entity.dart';

class SimilarMovieModel extends SimilarMovieEntity {
  SimilarMovieModel({
    required super.id,
    required super.title,
    required super.rating,
    required super.image,
  });

  factory SimilarMovieModel.fromJson(Map<String, dynamic> json) {
    return SimilarMovieModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      rating: (json['rating'] ?? 0).toDouble(),

      image: json['large_cover_image']?.toString().isNotEmpty == true
          ? json['large_cover_image'].toString()
          : json['medium_cover_image']?.toString() ?? '',
    );
  }
}