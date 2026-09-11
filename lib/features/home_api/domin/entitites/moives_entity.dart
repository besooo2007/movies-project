class MovieEntity {
  final int id;
  final String title;
  final String titleLong;
  final String image;
  final String backgroundImage;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;

  MovieEntity({
    required this.id,
    required this.title,
    required this.titleLong,
    required this.image,
    required this.backgroundImage,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
  });
}