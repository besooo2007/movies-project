import 'package:app/core/theme/AppColors.dart';
import 'package:app/features/movie_deatils/domin/entities/similar_movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimilarMoviesWidget extends StatelessWidget {
  final List<SimilarMovieEntity>? movies;

  const SimilarMoviesWidget({
    super.key,
    this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final movieList = movies ?? [];

    if (movieList.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Similar",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 12),

        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.68,
          ),
          itemCount: movieList.length,
          itemBuilder: (context, index) {
            final movie = movieList[index];

            return GestureDetector(
              onTap: () {
                context.push(
                  '/movie-details/${movie.id}',
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      movie.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.grey,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.white54,
                            size: 40,
                          ),
                        );
                      },
                      loadingBuilder: (
                        context,
                        child,
                        loadingProgress,
                      ) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return Container(
                          color: AppColors.grey,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      },
                    ),

                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              movie.rating.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),

                            const SizedBox(width: 4),

                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}