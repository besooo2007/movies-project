import 'package:app/features/home_api/domin/entitites/moives_entity.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<MovieEntity> movies;

  SearchSuccess({
    required this.movies,
  });
}

class SearchEmpty extends SearchState {}

class SearchFailure extends SearchState {
  final String message;

  SearchFailure({
    required this.message,
  });
}