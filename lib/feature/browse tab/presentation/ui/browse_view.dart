import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/browse_remote_data_source.dart';
import '../../data/repositories/browse_repository_impl.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import '../controller/browse_cubit.dart';
import '../controller/browse_state.dart';
import 'widgets/browse_movie_card.dart';
import 'widgets/genre_tab_item.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseCubit(
        getMoviesUseCase: GetMoviesUseCase(
          repository: BrowseRepositoryImpl(
            remoteDataSource: BrowseRemoteDataSourceImpl(),
          ),
        ),
      )..fetchMovies(),
      child: const BrowseScreenContent(),
    );
  }
}

class BrowseScreenContent extends StatelessWidget {
  const BrowseScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<BrowseCubit, BrowseState>(
          builder: (context, state) {
            if (state is BrowseLoading || state is BrowseInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.bottoncolora,
                ),
              );
            }

            if (state is BrowseError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textColor,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<BrowseCubit>().fetchMovies();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bottoncolora,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            color: Color(0xFF121312),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is BrowseSuccess) {
              if (state.genres.isEmpty) {
                return const Center(
                  child: Text(
                    'No categories available.',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Genres horizontal tabs
                  SizedBox(
                    height: 44,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.genres.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final genre = state.genres[index];
                        final isSelected = genre == state.selectedGenre;
                        return GenreTabItem(
                          genre: genre,
                          isSelected: isSelected,
                          onTap: () {
                            context.read<BrowseCubit>().selectGenre(genre);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Movies 2-column grid
                  Expanded(
                    child: state.filteredMovies.isEmpty
                        ? Center(
                            child: Text(
                              'No movies found for ${state.selectedGenre}',
                              style: const TextStyle(
                                color: AppColors.textColor,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          )
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.68,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: state.filteredMovies.length,
                            itemBuilder: (context, index) {
                              final movie = state.filteredMovies[index];
                              return BrowseMovieCard(movie: movie);
                            },
                          ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
