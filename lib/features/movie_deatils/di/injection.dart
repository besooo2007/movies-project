import 'package:app/features/movie_deatils/data/data_source/movie_details_remote_data_imp.dart';
import 'package:app/features/movie_deatils/data/data_source/movie_details_remote_data_source.dart';
import 'package:app/features/movie_deatils/domin/repositories/movie_details_repository_impl.dart';
import 'package:app/features/movie_deatils/domin/repositories/movies_repo.dart';
import 'package:app/features/movie_deatils/domin/use_case/get_movies.dart';
import 'package:app/features/movie_deatils/presntation/bloc/movie_details_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';



final movieDetailsGetIt = GetIt.instance;

void setupMovieDetailsInjection() {

  movieDetailsGetIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl:
            'https://movies-api.accel.li/api/v2/',
      ),
    ),
  );

  
  movieDetailsGetIt
      .registerLazySingleton<MovieDetailsRemoteDataSource>(
    () => MovieDetailsRemoteDataSourceImpl(
      movieDetailsGetIt<Dio>(),
    ),
  );

 
  movieDetailsGetIt
      .registerLazySingleton<MovieDetailsRepository>(
    () => MovieDetailsRepositoryImpl(
      movieDetailsGetIt<MovieDetailsRemoteDataSource>(),
    ),
  );

  movieDetailsGetIt
      .registerLazySingleton<GetMovieDetails>(
    () => GetMovieDetails(
      movieDetailsGetIt<MovieDetailsRepository>(),
    ),
  );

  // Bloc
  movieDetailsGetIt.registerFactory<MovieDetailsBloc>(
    () => MovieDetailsBloc(
      movieDetailsGetIt<GetMovieDetails>(),
    ),
  );
}