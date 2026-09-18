import 'package:app/features/movie_deatils/domin/entities/movies_deatils_entites.dart';



abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsSuccess extends MovieDetailsState {
  final MovieDetailsEntity movie;

  MovieDetailsSuccess(this.movie);
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);
}