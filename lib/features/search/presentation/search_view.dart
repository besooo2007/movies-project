import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/app_routes_name.dart';
import 'package:app/features/search/bloc/search_bloc.dart';
import 'package:app/features/search/bloc/search_event.dart';
import 'package:app/features/search/bloc/search_state.dart';
import 'package:app/features/search/di/search_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (_) => searchGetIt<SearchBloc>(),
      child: _SearchBody(searchController: _searchController),
    );
  }
}

class _SearchBody extends StatelessWidget {
  final TextEditingController searchController;

  const _SearchBody({required this.searchController});

  void _search(BuildContext context) {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      return;
    }

    context.read<SearchBloc>().add(SearchMoviesRequested(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                style: const TextStyle(color: Colors.white),
                onSubmitted: (_) {
                  _search(context);
                },
                decoration: InputDecoration(
                  hintText: 'Search for a movie...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Assets.icons.search.svg(width: 24, height: 24),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();

                      context.read<SearchBloc>().add(ClearSearch());
                    },
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF282A28),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return const Center(
                        child: Text(
                          'Search for your favorite movie',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      );
                    }

                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is SearchEmpty) {
                      return const Center(
                        child: Text(
                          'No movies found',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      );
                    }

                    if (state is SearchFailure) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is SearchSuccess) {
                      final movies = state.movies;

                      return GridView.builder(
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.62,
                            ),
                        itemBuilder: (context, index) {
                          final movie = movies[index];

                          return GestureDetector(
                            onTap: () {
                              debugPrint('🎬 SEARCH MOVIE ID: ${movie.id}');

                              context.push(
                                '${AppRoutesName.movieDetails}/${movie.id}',
                              );
                            },

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      movie.largeCoverImage,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: const Color(0xFF282A28),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.movie,
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
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xFFF6BD00),
                                      size: 16,
                                    ),

                                    const SizedBox(width: 4),

                                    Text(
                                      movie.rating.toString(),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),

                                    const Spacer(),

                                    Text(
                                      movie.year.toString(),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
