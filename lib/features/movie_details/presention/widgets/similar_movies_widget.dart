import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class SimilarMovieItem {
  final AssetGenImage image;
  final String rating;

  const SimilarMovieItem({
    required this.image,
    required this.rating,
  });
}
class SimilarMoviesWidget extends StatelessWidget {
  final List<SimilarMovieItem>? movies;

  const SimilarMoviesWidget({
    super.key,
    this.movies,
  });
  @override
  Widget build(BuildContext context) {
    final movieList = movies ??
        [
          SimilarMovieItem(image: Assets.images.imgSimilar1, rating: "7.7"),
          SimilarMovieItem(image: Assets.images.imgSimilar2, rating: "7.7"),
          SimilarMovieItem(image: Assets.images.imgSimilar3, rating: "7.7"),
          SimilarMovieItem(image: Assets.images.imgSimilar4, rating: "7.7"),
        ];

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
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  movie.image.image(
                    fit: BoxFit.cover,
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
                            movie.rating,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Assets.icons.icStar.svg(
                            width: 14,
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
