import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/features/home_api/di/injiction.dart';
import 'package:app/features/home_api/domin/entitites/moives_entity.dart';
import 'package:app/features/home_api/presnation/bloc/home_bloc.dart';
import 'package:app/features/home_api/presnation/bloc/home_event.dart';
import 'package:app/features/home_api/presnation/bloc/home_state.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => homeGetIt<HomeBloc>()..add(GetMoviesRequested()),
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen();

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  int _currentPosterIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeFailure) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (state is HomeSuccess) {
            final movies = state.movies;

            if (movies.isEmpty) {
              return const Center(
                child: Text(
                  'No movies found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            print('Movies from API: ${movies.length}');
            print('First movie: ${movies.first.title}');
            print('Image: ${movies.first.largeCoverImage}');
            print('Rating: ${movies.first.rating}');

            final carouselMovies = movies.take(10).toList();

            final actionMovies = movies.where((movie) {
              return movie.genres.any(
                (genre) => genre.toLowerCase() == 'action',
              );
            }).toList();

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Stack(
                            key: ValueKey<int>(_currentPosterIndex),
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                carouselMovies[_currentPosterIndex]
                                    .backgroundImage,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return Container(
                                    color: const Color(0xFF121312),
                                  );
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.45),
                                      Colors.black.withValues(alpha: 0.65),
                                      const Color(0xCC121312),
                                      const Color(0xFF121312),
                                    ],
                                    stops: const [0.0, 0.4, 0.75, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        bottom: false,
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            Center(
                              child: Assets.images.availableNow.image(
                                height: 93,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CarouselSlider.builder(
                              itemCount: carouselMovies.length,
                              itemBuilder: (context, index, realIndex) {
                                return _buildCarouselCard(
                                  carouselMovies[index],
                                );
                              },
                              options: CarouselOptions(
                                height: 351,
                                initialPage: 0,
                                viewportFraction: 0.58,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.22,
                                enableInfiniteScroll: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentPosterIndex =
                                        index % carouselMovies.length;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Assets.images.watchNow.image(
                                height: 146,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Action',
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: AppColors.textColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go(AppRoutesName.updateProfile);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'See More',
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: AppColors.bottoncolora,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward,
                                color: Color(0xFFF6BD00),
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: actionMovies.length,
                      itemBuilder: (context, index) {
                        return _buildMovieCard(
                          actionMovies[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildCarouselCard(MovieEntity movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              movie.largeCoverImage,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: const Color(0xFF282A28),
                );
              },
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.rating.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Assets.icons.star.image(width: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieCard(MovieEntity movie) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              movie.largeCoverImage,
              width: 120,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 120,
                  height: 180,
                  color: const Color(0xFF282A28),
                );
              },
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.rating.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Assets.icons.star.image(width: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}