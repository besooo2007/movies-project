import 'package:app/features/movie_deatils/data/data_source/movie_details_remote_data_imp.dart';
import 'package:app/features/movie_deatils/data/data_source/movie_details_remote_data_source.dart';
import 'package:app/features/movie_deatils/domin/repositories/movie_details_repository_impl.dart';
import 'package:app/features/movie_deatils/domin/repositories/movies_repo.dart';
import 'package:app/features/movie_deatils/domin/use_case/get_movie_details_usecase.dart';
import 'package:app/features/movie_deatils/domin/use_case/get_movies.dart';
import 'package:app/features/movie_deatils/presntation/bloc/movie_details_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final movieDetailsGetIt = GetIt.instance;

void setupMovieDetailsInjection() {
  // Dio
  if (!movieDetailsGetIt.isRegistered<Dio>()) {
    movieDetailsGetIt.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: 'https://movies-api.accel.li/api/v2/',
        ),
      ),
    );
  }

 
  if (!movieDetailsGetIt
      .isRegistered<MovieDetailsRemoteDataSource>()) {
    movieDetailsGetIt.registerLazySingleton<MovieDetailsRemoteDataSource>(
      () => MovieDetailsRemoteDataSourceImpl(
        movieDetailsGetIt<Dio>(),
      ),
    );
  }


  if (!movieDetailsGetIt
      .isRegistered<MovieDetailsRepository>()) {
    movieDetailsGetIt.registerLazySingleton<MovieDetailsRepository>(
      () => MovieDetailsRepositoryImpl(
        movieDetailsGetIt<MovieDetailsRemoteDataSource>(),
      ),
    );
  }


  if (!movieDetailsGetIt.isRegistered<GetMovieDetails>()) {
    movieDetailsGetIt.registerLazySingleton<GetMovieDetails>(
      () => GetMovieDetails(
        movieDetailsGetIt<MovieDetailsRepository>(),
      ),
    );
  }

 
  if (!movieDetailsGetIt.isRegistered<GetSimilarMovies>()) {
    movieDetailsGetIt.registerLazySingleton<GetSimilarMovies>(
      () => GetSimilarMovies(
        movieDetailsGetIt<MovieDetailsRepository>(),
      ),
    );
  }

  
  movieDetailsGetIt.registerFactory<MovieDetailsBloc>(
    () => MovieDetailsBloc(
      movieDetailsGetIt<GetMovieDetails>(),
      movieDetailsGetIt<GetSimilarMovies>(),
    ),
  );
}