import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class GenresWidget extends StatelessWidget {
  final List<String>? genres;

  const GenresWidget({
    super.key,
    this.genres,
  });

  @override
  Widget build(BuildContext context) {
    final list = genres ??
        [
          "Action",
          "Sci-Fi",
          "Adventure",
          "Fantasy",
          "Horror",
        ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Genres",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: list.map((genre) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                genre,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textColor,
                    ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}