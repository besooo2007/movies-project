import 'package:app/features/movie_deatils/domin/entities/movies_deatils_entites.dart';
import 'package:app/features/movie_deatils/domin/entities/similar_movie_entity.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsEntity movie;
  final List<SimilarMovieEntity> similarMovies;

  MovieDetailsSuccess(
    this.movie,
    this.similarMovies,
  );
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}