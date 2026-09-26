abstract class SearchEvent {}

class SearchMoviesRequested extends SearchEvent {
  final String query;

  SearchMoviesRequested({
    required this.query,
  });
}

class ClearSearch extends SearchEvent {}