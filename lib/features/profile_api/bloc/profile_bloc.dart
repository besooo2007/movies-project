import 'package:app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:app/features/auth/data/models/user_model.dart';
import 'package:app/features/profile_api/use_case/add_to_history_use_case.dart';
import 'package:app/features/profile_api/use_case/add_to_watch_list_use_case.dart';
import 'package:app/features/profile_api/use_case/get_history_use_case.dart';
import 'package:app/features/profile_api/use_case/get_saved_movies_use_case.dart';
import 'package:app/features/profile_api/use_case/get_watch_list_use_case.dart';
import 'package:app/features/profile_api/use_case/remove_from_watch_list_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRemoteDataSource authRemoteDataSource;
  final GetWatchListUseCase getWatchListUseCase;
  final GetHistoryUseCase getHistoryUseCase;
  final AddToWatchListUseCase addToWatchListUseCase;
  final RemoveFromWatchListUseCase removeFromWatchListUseCase;
  final AddToHistoryUseCase addToHistoryUseCase;
  final GetSavedMoviesUseCase getSavedMoviesUseCase;

  ProfileBloc({
    required this.authRemoteDataSource,
    required this.getWatchListUseCase,
    required this.getHistoryUseCase,
    required this.addToWatchListUseCase,
    required this.removeFromWatchListUseCase,
    required this.addToHistoryUseCase,
    required this.getSavedMoviesUseCase,
  }) : super(ProfileInitial()) {
    on<GetProfileRequested>(_getProfile);
    on<AddMovieToWatchList>(_addToWatchList);
    on<RemoveMovieFromWatchList>(_removeFromWatchList);
    on<AddMovieToHistory>(_addToHistory);
  }

  Future<void> _getProfile(
    GetProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final user = authRemoteDataSource.getCurrentUser();

      if (user == null) {
        emit(
          ProfileFailure(
            message: 'User is not logged in',
          ),
        );
        return;
      }

      final profileData =
          await authRemoteDataSource.getUserProfile();

      if (profileData == null) {
        emit(
          ProfileFailure(
            message: 'Profile not found',
          ),
        );
        return;
      }

      final userModel = UserModel.fromJson(profileData);

      final watchListIds = await getWatchListUseCase();
      final historyIds = await getHistoryUseCase();

      final watchListMovies =
          await getSavedMoviesUseCase(
        movieIds: watchListIds,
      );

      final historyMovies =
          await getSavedMoviesUseCase(
        movieIds: historyIds,
      );

      emit(
        ProfileSuccess(
          user: userModel,
          watchListIds: watchListIds,
          historyIds: historyIds,
          watchListMovies: watchListMovies,
          historyMovies: historyMovies,
        ),
      );
    } catch (e) {
      emit(
        ProfileFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _addToHistory(
    AddMovieToHistory event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await addToHistoryUseCase(
        movieId: event.movieId,
      );

      if (state is ProfileSuccess) {
        final currentState = state as ProfileSuccess;

        final historyIds =
            List<int>.from(currentState.historyIds);

        if (!historyIds.contains(event.movieId)) {
          historyIds.add(event.movieId);
        }

        final historyMovies =
            await getSavedMoviesUseCase(
          movieIds: historyIds,
        );

        emit(
          ProfileSuccess(
            user: currentState.user,
            watchListIds: currentState.watchListIds,
            historyIds: historyIds,
            watchListMovies: currentState.watchListMovies,
            historyMovies: historyMovies,
          ),
        );
      }
    } catch (e) {
      emit(
        ProfileFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _addToWatchList(
    AddMovieToWatchList event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await addToWatchListUseCase(
        movieId: event.movieId,
      );

      if (state is ProfileSuccess) {
        final currentState = state as ProfileSuccess;

        final watchListIds =
            List<int>.from(currentState.watchListIds);

        if (!watchListIds.contains(event.movieId)) {
          watchListIds.add(event.movieId);
        }

        final watchListMovies =
            await getSavedMoviesUseCase(
          movieIds: watchListIds,
        );

        emit(
          ProfileSuccess(
            user: currentState.user,
            watchListIds: watchListIds,
            historyIds: currentState.historyIds,
            watchListMovies: watchListMovies,
            historyMovies: currentState.historyMovies,
          ),
        );
      }
    } catch (e) {
      emit(
        ProfileFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _removeFromWatchList(
    RemoveMovieFromWatchList event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await removeFromWatchListUseCase(
        movieId: event.movieId,
      );

      if (state is ProfileSuccess) {
        final currentState = state as ProfileSuccess;

        final watchListIds =
            List<int>.from(currentState.watchListIds);

        watchListIds.remove(event.movieId);

        final watchListMovies =
            await getSavedMoviesUseCase(
          movieIds: watchListIds,
        );

        emit(
          ProfileSuccess(
            user: currentState.user,
            watchListIds: watchListIds,
            historyIds: currentState.historyIds,
            watchListMovies: watchListMovies,
            historyMovies: currentState.historyMovies,
          ),
        );
      }
    } catch (e) {
      emit(
        ProfileFailure(
          message: e.toString(),
        ),
      );
    }
  }
}