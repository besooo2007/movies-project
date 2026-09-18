import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/features/movie_details/presention/widgets/stats_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeroHeaderWidget extends StatelessWidget {
  final String title;
  final String year;
  final String likes;
  final String duration;
  final String rating;
  final VoidCallback? onPlayTap;
  final VoidCallback? onWatchTap;
  final VoidCallback? onBookmarkTap;

  const HeroHeaderWidget({
    super.key,
    this.title = "Doctor Strange in the Multiverse of Madness",
    this.year = "2022",
    this.likes = "15",
    this.duration = "90",
    this.rating = "7.6",
    this.onPlayTap,
    this.onWatchTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: screenHeight * 0.55,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Assets.images.doctorStrange.image(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                      AppColors.background.withValues(alpha: 0.7),
                      AppColors.background,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.25, 0.8, 1.0],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            Navigator.maybePop(context);
                          }
                        },
                        icon: Assets.icons.icBack.svg(
                          width: 18,
                          height: 28,
                        ),
                      ),

                      IconButton(
                        onPressed: onBookmarkTap ?? () {},
                        icon: Assets.icons.icBookmark.svg(
                          width: 20,
                          height: 29,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Center(
                child: GestureDetector(
                  onTap: onPlayTap ?? () {},
                  child: Assets.icons.icPlay.svg(
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,

                ),
              ),
              const SizedBox(height: 8),
              Text(
                year,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: "Watch",
                onPressed: onWatchTap ?? () {},
                color: AppColors.red,
              ),
              const SizedBox(height: 16),
              StatsRowWidget(
                likes: likes,
                duration: duration,
                rating: rating,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
