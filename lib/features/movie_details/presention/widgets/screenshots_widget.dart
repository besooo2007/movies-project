import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class ScreenshotsWidget extends StatelessWidget {
  final List<AssetGenImage>? screenshots;

  const ScreenshotsWidget({
    super.key,
    this.screenshots,
  });
  @override
  Widget build(BuildContext context) {
    final screenshotList = screenshots ??
        [
          Assets.images.imgScreenshot1,
          Assets.images.imgScreenshot2,
          Assets.images.imgScreenshot3,
        ];
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
          children: screenshotList.map((asset) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: asset.image(
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
