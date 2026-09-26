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
import 'package:app/features/profile_api/bloc/profile_bloc.dart';
import 'package:app/features/profile_api/bloc/profile_event.dart';
import 'package:app/features/profile_api/bloc/profile_state.dart';
import 'package:app/features/profile_api/di/di_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;

  const MovieDetailsView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailsBloc>(
          create: (_) {
            return movieDetailsGetIt<MovieDetailsBloc>()
              ..add(GetMovieDetailsEvent(movieId));
          },
        ),

        BlocProvider<ProfileBloc>(
          create: (_) {
            return profileGetIt<ProfileBloc>()..add(GetProfileRequested());
          },
        ),
      ],
      child: const MovieDetailsBody(),
    );
  }
}

class MovieDetailsBody extends StatefulWidget {
  const MovieDetailsBody({super.key});

  @override
  State<MovieDetailsBody> createState() => _MovieDetailsBodyState();
}

class _MovieDetailsBodyState extends State<MovieDetailsBody> {
  bool? _isSaved;

  bool _historyAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

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

            if (!_historyAdded) {
              _historyAdded = true;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;

                context.read<ProfileBloc>().add(
                  AddMovieToHistory(movieId: movie.id),
                );

                debugPrint('🎬 ADDED TO HISTORY: ${movie.id}');
              });
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, profileState) {
                      if (profileState is ProfileSuccess) {
                        final saved = profileState.watchListIds.contains(
                          movie.id,
                        );

                        if (_isSaved == null) {
                          setState(() {
                            _isSaved = saved;
                          });
                        }
                      }

                      if (profileState is ProfileFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(profileState.message)),
                        );
                      }
                    },

                    child: Builder(
                      builder: (context) {
                        final bool isSaved = _isSaved ?? false;

                        return HeroHeaderWidget(
                          movie: movie,

                          isSaved: isSaved,

                          onBookmarkTap: () {
                            final profileBloc = context.read<ProfileBloc>();

                            // Toggle value
                            final bool newValue = !isSaved;

                            setState(() {
                              _isSaved = newValue;
                            });

                            profileBloc.add(
                              AddMovieToWatchList(movieId: movie.id),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
