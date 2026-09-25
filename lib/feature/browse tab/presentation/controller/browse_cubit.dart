import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final GetMoviesUseCase getMoviesUseCase;

  BrowseCubit({required this.getMoviesUseCase}) : super(const BrowseInitial());

  Future<void> fetchMovies() async {
    emit(const BrowseLoading());
    try {
      final List<MovieEntity> movies = await getMoviesUseCase();

      final Set<String> genreSet = <String>{};
      for (final movie in movies) {
        for (final genre in movie.genres) {
          final trimmed = genre.trim();
          if (trimmed.isNotEmpty) {
            genreSet.add(trimmed);
          }
        }
      }

      final List<String> genres = genreSet.toList();
      final String selectedGenre = genres.isNotEmpty ? genres.first : '';

      final List<MovieEntity> filteredMovies = selectedGenre.isNotEmpty
          ? movies.where((m) => m.genres.contains(selectedGenre)).toList()
          : movies;

      emit(
        BrowseSuccess(
          allMovies: movies,
          genres: genres,
          selectedGenre: selectedGenre,
          filteredMovies: filteredMovies,
        ),
      );
    } catch (e) {
      emit(BrowseError(e.toString()));
    }
  }

  void selectGenre(String genre) {
    final currentState = state;
    if (currentState is BrowseSuccess) {
      if (currentState.selectedGenre == genre) return;

      final List<MovieEntity> filtered = currentState.allMovies
          .where((m) => m.genres.contains(genre))
          .toList();

      emit(
        currentState.copyWith(
          selectedGenre: genre,
          filteredMovies: filtered,
        ),
      );
    }
  }
}
