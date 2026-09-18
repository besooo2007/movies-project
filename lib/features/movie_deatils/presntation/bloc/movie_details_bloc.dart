import 'package:app/features/movie_deatils/domin/use_case/get_movie_details_usecase.dart';
import 'package:app/features/movie_deatils/domin/use_case/get_movies.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc
    extends Bloc<MovieDetailsEvent, MovieDetailsState> {

  final GetMovieDetails getMovieDetails;
  final GetSimilarMovies getSimilarMovies;

  MovieDetailsBloc(
    this.getMovieDetails,
    this.getSimilarMovies,
  ) : super(MovieDetailsInitial()) {

    on<GetMovieDetailsEvent>(
      getMovieDetailsData,
    );
  }

  Future<void> getMovieDetailsData(
    GetMovieDetailsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoading());

    try {
      final movie = await getMovieDetails(
        event.movieId,
      );

      final similarMovies = await getSimilarMovies(
        event.movieId,
      );

      emit(
        MovieDetailsSuccess(
          movie,
          similarMovies,
        ),
      );
    } catch (e) {
      emit(
        MovieDetailsError(
          e.toString(),
        ),
      );
    }
  }
}