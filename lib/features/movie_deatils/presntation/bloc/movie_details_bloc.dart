import 'package:app/features/movie_deatils/domin/use_case/get_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsBloc
    extends Bloc<MovieDetailsEvent, MovieDetailsState> {

  final GetMovieDetails getMovieDetails;

  MovieDetailsBloc(
    this.getMovieDetails,
  ) : super(MovieDetailsInitial()) {

    on<GetMovieDetailsEvent>(
      getMovieDetailsData,
    );
  }

  Future<void> getMovieDetailsData(
    GetMovieDetailsEvent event,
    Emitter<MovieDetailsState> emit,
  ) async {

    emit(
      MovieDetailsLoading(),
    );

    try {

      final movie = await getMovieDetails(
        event.movieId,
      );

      emit(
        MovieDetailsSuccess(
          movie,
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