import 'package:app/core/gen/assets.gen.dart';
import 'package:app/feature/browse%20tab/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class BrowseMovieCard extends StatelessWidget {
  final MovieEntity movie;

  const BrowseMovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final String imageUrl = movie.mediumCoverImage.isNotEmpty
        ? movie.mediumCoverImage
        : movie.largeCoverImage;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Movie poster image with loading & error handling
          if (imageUrl.isNotEmpty)
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: const Color(0xFF282A28),
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                      strokeWidth: 2,
                      color: const Color(0xFFF6BD00),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return _buildErrorPlaceholder();
              },
            )
          else
            _buildErrorPlaceholder(),

          // Rating badge at top-left
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.rating > 0 ? movie.rating.toStringAsFixed(1) : '0.0',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(width: 3),
                  Assets.icons.star.image(width: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: const Color(0xFF282A28),
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.movie_outlined,
              color: Color(0xFFF6BD00),
              size: 36,
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
