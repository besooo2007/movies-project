import '../../domain/entities/movie_entity.dart';

abstract class BrowseState {
  const BrowseState();
}

class BrowseInitial extends BrowseState {
  const BrowseInitial();
}

class BrowseLoading extends BrowseState {
  const BrowseLoading();
}

class BrowseSuccess extends BrowseState {
  final List<MovieEntity> allMovies;
  final List<String> genres;
  final String selectedGenre;
  final List<MovieEntity> filteredMovies;

  const BrowseSuccess({
    required this.allMovies,
    required this.genres,
    required this.selectedGenre,
    required this.filteredMovies,
  });

  BrowseSuccess copyWith({
    List<MovieEntity>? allMovies,
    List<String>? genres,
    String? selectedGenre,
    List<MovieEntity>? filteredMovies,
  }) {
    return BrowseSuccess(
      allMovies: allMovies ?? this.allMovies,
      genres: genres ?? this.genres,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      filteredMovies: filteredMovies ?? this.filteredMovies,
    );
  }
}

class BrowseError extends BrowseState {
  final String message;

  const BrowseError(this.message);
}
