import 'package:app/features/auth/domin/entities/user_entity.dart';
import 'package:app/features/movie_deatils/data/models/movie_details_model.dart';

abstract class ProfileState {}


class ProfileInitial extends ProfileState {}




class ProfileLoading extends ProfileState {}


class ProfileSuccess extends ProfileState {
  final UserEntity user;

  final List<int> watchListIds;
  final List<int> historyIds;


  final List<MovieDetailsModel> watchListMovies;
  final List<MovieDetailsModel> historyMovies;

  ProfileSuccess({
    required this.user,
    required this.watchListIds,
    required this.historyIds,
    required this.watchListMovies,
    required this.historyMovies,
  });
}



class ProfileFailure extends ProfileState {
  final String message;

  ProfileFailure({
    required this.message,
  });
}