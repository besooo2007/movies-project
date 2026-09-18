import 'package:app/features/movie_deatils/data/data_source/movie_details_remote_data_source.dart';
import 'package:app/features/movie_deatils/domin/entities/movies_deatils_entites.dart';
import 'package:app/features/movie_deatils/domin/entities/similar_movie_entity.dart';
import 'package:app/features/movie_deatils/domin/repositories/movies_repo.dart';

class MovieDetailsRepositoryImpl
    implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<MovieDetailsEntity> getMovieDetails(
    int movieId,
  ) async {
    return await remoteDataSource.getMovieDetails(
      movieId,
    );
  }

  @override
  Future<List<SimilarMovieEntity>> getSimilarMovies(
    int movieId,
  ) async {
    return await remoteDataSource.getSimilarMovies(
      movieId,
    );
  }
}