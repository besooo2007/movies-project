import 'package:app/core/theme/AppColors.dart';
import 'package:app/features/movie_details/presention/widgets/cast_widget.dart';
import 'package:app/features/movie_details/presention/widgets/genres_widget.dart';
import 'package:app/features/movie_details/presention/widgets/hero_header_widget.dart';
import 'package:app/features/movie_details/presention/widgets/screenshots_widget.dart';
import 'package:app/features/movie_details/presention/widgets/similar_movies_widget.dart';
import 'package:app/features/movie_details/presention/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeroHeaderWidget(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 8),
                  ScreenshotsWidget(),
                  SizedBox(height: 24),
                  SimilarMoviesWidget(),
                  SizedBox(height: 24),
                  SummaryWidget(),
                  SizedBox(height: 24),
                  CastWidget(),
                  SizedBox(height: 24),
                  GenresWidget(),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
