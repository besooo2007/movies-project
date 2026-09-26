import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:app/features/search/data/search_remote_data_source.dart';
import 'package:app/features/search/data/search_remote_data_source_impl.dart';

import 'package:app/features/search/domin/repo/search_Repository.dart';
import 'package:app/features/search/domin/repo/search_repository_impl.dart';

import 'package:app/features/search/use_case/search_movies_use_case.dart';
import 'package:app/features/search/bloc/search_bloc.dart';

final searchGetIt = GetIt.instance;

void setupSearchInjection() {

  // DATA SOURCE
  searchGetIt.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(
      dio: searchGetIt<Dio>(),
    ),
  );

  // REPOSITORY
  searchGetIt.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: searchGetIt<SearchRemoteDataSource>(),
    ),
  );

  // USE CASE
  searchGetIt.registerLazySingleton<SearchMoviesUseCase>(
    () => SearchMoviesUseCase(
      repository: searchGetIt<SearchRepository>(),
    ),
  );

  // BLOC
  searchGetIt.registerFactory<SearchBloc>(
    () => SearchBloc(
      searchMoviesUseCase: searchGetIt<SearchMoviesUseCase>(),
    ),
  );
}