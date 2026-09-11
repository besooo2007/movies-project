
import 'package:app/features/home_api/data/data%20source/home_remote_data_imp.dart';
import 'package:app/features/home_api/data/data%20source/home_remote_data_source.dart';
import 'package:app/features/home_api/domin/repository/home_repo.dart';
import 'package:app/features/home_api/domin/repository/home_repo_imp.dart';
import 'package:app/features/home_api/domin/use_case/get_movies_usecase.dart';
import 'package:app/features/home_api/presnation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

final homeGetIt = GetIt.instance;

void setupHomeInjection() {
  homeGetIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );

  homeGetIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeGetIt<HomeRemoteDataSource>(),
    ),
  );

  homeGetIt.registerLazySingleton<GetMovies>(
    () => GetMovies(
      homeGetIt<HomeRepository>(),
    ),
  );

  homeGetIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      homeGetIt<GetMovies>(),
    ),
  );
}