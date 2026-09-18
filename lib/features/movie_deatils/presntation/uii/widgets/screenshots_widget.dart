import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class ScreenshotsWidget extends StatelessWidget {
  final List<String>? screenshots;

  const ScreenshotsWidget({
    super.key,
    this.screenshots,
  });

  @override
  Widget build(BuildContext context) {
    final screenshotList = screenshots ?? [];

   
    if (screenshotList.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Screen Shots",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Column(
            children: [
              Assets.images.imgScreenshot1.image(
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              Assets.images.imgScreenshot2.image(
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              Assets.images.imgScreenshot3.image(
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Screen Shots",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),

        Column(
          children: screenshotList.map((imageUrl) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 180,
                      color: AppColors.grey,
                      alignment: Alignment.center,
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
                      width: double.infinity,
                      height: 180,
                      color: AppColors.grey,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}