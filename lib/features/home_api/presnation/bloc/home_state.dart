
import 'package:app/features/home_api/domin/entitites/moives_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<MovieEntity> movies;

  HomeSuccess(this.movies);
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}