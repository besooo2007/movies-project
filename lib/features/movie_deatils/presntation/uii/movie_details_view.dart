import 'package:app/core/theme/AppColors.dart';
import 'package:app/features/movie_deatils/di/injection.dart';
import 'package:app/features/movie_deatils/presntation/bloc/movie_details_bloc.dart';
import 'package:app/features/movie_deatils/presntation/bloc/movie_details_event.dart';
import 'package:app/features/movie_deatils/presntation/bloc/movie_details_state.dart';
import 'package:app/features/movie_deatils/presntation/uii/widgets/cast_widget.dart';
import 'package:app/features/movie_deatils/presntation/uii/widgets/genres_widget.dart';
import 'package:app/features/movie_deatils/presntation/uii/widgets/hero_header_widget.dart';
import 'package:app/features/movie_deatils/presntation/uii/widgets/screenshots_widget.dart';
import 'package:app/features/movie_deatils/presntation/uii/widgets/similar_movies_widget.dart';
import 'package:app/features/movie_deatils/presntation/uii/widgets/summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;

  const MovieDetailsView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          movieDetailsGetIt<MovieDetailsBloc>()
            ..add(GetMovieDetailsEvent(movieId)),
      child: const MovieDetailsBody(),
    );
  }
}

class MovieDetailsBody extends StatelessWidget {
  const MovieDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          // Loading
          if (state is MovieDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (state is MovieDetailsError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (state is MovieDetailsSuccess) {
            final movie = state.movie;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HERO
                  HeroHeaderWidget(movie: movie),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        ScreenshotsWidget(screenshots: movie.screenshots),

                        const SizedBox(height: 24),

                        SimilarMoviesWidget(movies: state.similarMovies),

                        const SizedBox(height: 24),

                        SummaryWidget(summary: movie.description),

                        const SizedBox(height: 24),
                        CastWidget(cast: movie.cast),

                        const SizedBox(height: 24),

                        GenresWidget(genres: movie.genres),

                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
