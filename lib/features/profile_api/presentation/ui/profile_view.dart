import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/features/movie_deatils/data/models/movie_details_model.dart';
import 'package:app/features/profile_api/bloc/profile_bloc.dart';
import 'package:app/features/profile_api/bloc/profile_event.dart';
import 'package:app/features/profile_api/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (_) {
        return GetIt.instance<ProfileBloc>()..add(GetProfileRequested());
      },
      child: const _ProfileBody(),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const SizedBox(height: 20),

              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ProfileFailure) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    );
                  }

                  if (state is ProfileSuccess) {
                    final user = state.user;

                    final watchListCount = state.watchListIds.length;

                    final historyCount = state.historyIds.length;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              ClipOval(
                                child: Assets.images.avatar1.image(
                                  width: 84,
                                  height: 84,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                user.name ?? 'User',
                                style: const TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '$watchListCount',
                                      style: const TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    const Text(
                                      'Wish List',
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  children: [
                                    Text(
                                      '$historyCount',
                                      style: const TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    const Text(
                                      'History',
                                      style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
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

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go(AppRoutesName.updateProfile);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bottoncolora,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Color(0xFF121312),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Logout
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Exit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),

                            SizedBox(width: 6),

                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              const TabBar(
                indicatorColor: AppColors.bottoncolora,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.format_list_bulleted,
                          color: AppColors.bottoncolora,
                          size: 22,
                        ),

                        SizedBox(width: 8),

                        Text('Watch List'),
                      ],
                    ),
                  ),

                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder,
                          color: AppColors.bottoncolora,
                          size: 22,
                        ),

                        SizedBox(width: 8),

                        Text('History'),
                      ],
                    ),
                  ),
                ],
              ),

              Expanded(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ProfileFailure) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state is ProfileSuccess) {
                      return TabBarView(
                        children: [
                          // WATCH LIST
                          _MoviesView(movies: state.watchListMovies),

                          // HISTORY
                          _MoviesView(movies: state.historyMovies),
                        ],
                      );
                    }

                    return TabBarView(children: [_emptyView(), _emptyView()]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _emptyView() {
    return Center(
      child: Assets.images.empty.image(
        width: 140,
        height: 140,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _MoviesView extends StatelessWidget {
  final List<MovieDetailsModel> movies;

  const _MoviesView({required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(
        child: Assets.images.empty.image(
          width: 140,
          height: 140,
          fit: BoxFit.contain,
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      itemCount: movies.length,

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.62,
      ),

      itemBuilder: (context, index) {
        final movie = movies[index];

        final imageUrl = movie.largeCoverImage.isNotEmpty
            ? movie.largeCoverImage
            : movie.backgroundImage;

        return GestureDetector(
          onTap: () {
            debugPrint('🎬 Movie ID: ${movie.id}');

            context.push('${AppRoutesName.movieDetails}/${movie.id}');
          },

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),

                  child: imageUrl.isEmpty
                      ? Container(
                          width: double.infinity,
                          color: const Color(0xFF1D1E1D),
                          child: const Center(
                            child: Icon(
                              Icons.movie,
                              color: Colors.white,
                              size: 45,
                            ),
                          ),
                        )
                      : Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,

                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },

                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('IMAGE ERROR: $error');

                            debugPrint('IMAGE URL: $imageUrl');

                            return Container(
                              width: double.infinity,
                              color: const Color(0xFF1D1E1D),
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                  size: 45,
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                movie.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFF6BD00), size: 16),

                  const SizedBox(width: 4),

                  Text(
                    movie.rating.toString(),
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),

                  const Spacer(),

                  Text(
                    movie.year.toString(),
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
