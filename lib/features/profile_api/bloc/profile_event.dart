abstract class ProfileEvent {}

class GetProfileRequested extends ProfileEvent {}

class AddMovieToWatchList extends ProfileEvent {
  final int movieId;

  AddMovieToWatchList({
    required this.movieId,
  });
}

class RemoveMovieFromWatchList extends ProfileEvent {
  final int movieId;

  RemoveMovieFromWatchList({
    required this.movieId,
  });
}

class AddMovieToHistory extends ProfileEvent {
  final int movieId;

  AddMovieToHistory({
    required this.movieId,
  });
}