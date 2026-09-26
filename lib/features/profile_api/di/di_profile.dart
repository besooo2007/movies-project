import 'package:app/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:app/features/movie_deatils/data/data_source/movie_details_remote_data_imp.dart';
import 'package:app/features/movie_deatils/data/data_source/movie_details_remote_data_source.dart';

import 'package:app/features/profile_api/bloc/profile_bloc.dart';
import 'package:app/features/profile_api/data/profile_remote_data_source.dart';
import 'package:app/features/profile_api/domin/repo/profile_repository.dart';
import 'package:app/features/profile_api/domin/repo/profile_repository_impl.dart';

import 'package:app/features/profile_api/use_case/add_to_history_use_case.dart';
import 'package:app/features/profile_api/use_case/add_to_watch_list_use_case.dart';
import 'package:app/features/profile_api/use_case/get_history_use_case.dart';
import 'package:app/features/profile_api/use_case/get_saved_movies_use_case.dart';
import 'package:app/features/profile_api/use_case/get_watch_list_use_case.dart';
import 'package:app/features/profile_api/use_case/remove_from_watch_list_use_case.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final profileGetIt = GetIt.instance;

void setupProfileInjection() {


  if (!profileGetIt.isRegistered<ProfileRemoteDataSource>()) {
    profileGetIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(
        firestore: FirebaseFirestore.instance,
        firebaseAuth: FirebaseAuth.instance,
      ),
    );
  }

  

  if (!profileGetIt.isRegistered<ProfileRepository>()) {
    profileGetIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(
        remoteDataSource: profileGetIt<ProfileRemoteDataSource>(),
      ),
    );
  }


  if (!profileGetIt.isRegistered<GetHistoryUseCase>()) {
    profileGetIt.registerLazySingleton<GetHistoryUseCase>(
      () => GetHistoryUseCase(repository: profileGetIt<ProfileRepository>()),
    );
  }

  if (!profileGetIt.isRegistered<AddToHistoryUseCase>()) {
    profileGetIt.registerLazySingleton<AddToHistoryUseCase>(
      () => AddToHistoryUseCase(repository: profileGetIt<ProfileRepository>()),
    );
  }

  

  if (!profileGetIt.isRegistered<GetWatchListUseCase>()) {
    profileGetIt.registerLazySingleton<GetWatchListUseCase>(
      () => GetWatchListUseCase(repository: profileGetIt<ProfileRepository>()),
    );
  }

  if (!profileGetIt.isRegistered<AddToWatchListUseCase>()) {
    profileGetIt.registerLazySingleton<AddToWatchListUseCase>(
      () =>
          AddToWatchListUseCase(repository: profileGetIt<ProfileRepository>()),
    );
  }

  if (!profileGetIt.isRegistered<RemoveFromWatchListUseCase>()) {
    profileGetIt.registerLazySingleton<RemoveFromWatchListUseCase>(
      () => RemoveFromWatchListUseCase(
        repository: profileGetIt<ProfileRepository>(),
      ),
    );
  }



  if (!profileGetIt.isRegistered<MovieDetailsRemoteDataSource>()) {
    profileGetIt.registerLazySingleton<MovieDetailsRemoteDataSource>(
      () => MovieDetailsRemoteDataSourceImpl(profileGetIt<Dio>()),
    );
  }



  if (!profileGetIt.isRegistered<GetSavedMoviesUseCase>()) {
    profileGetIt.registerLazySingleton<GetSavedMoviesUseCase>(
      () => GetSavedMoviesUseCase(
        remoteDataSource: profileGetIt<MovieDetailsRemoteDataSource>(),
      ),
    );
  }

  

  if (!profileGetIt.isRegistered<ProfileBloc>()) {
    profileGetIt.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        authRemoteDataSource: profileGetIt<AuthRemoteDataSource>(),

        getWatchListUseCase: profileGetIt<GetWatchListUseCase>(),

        getHistoryUseCase: profileGetIt<GetHistoryUseCase>(),

        addToWatchListUseCase: profileGetIt<AddToWatchListUseCase>(),

        removeFromWatchListUseCase: profileGetIt<RemoveFromWatchListUseCase>(),

        addToHistoryUseCase: profileGetIt<AddToHistoryUseCase>(),

        // NEW
        getSavedMoviesUseCase: profileGetIt<GetSavedMoviesUseCase>(),
      ),
    );
  }
}
