import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Assets.images.onBoarding1.image(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            Positioned(
              left: 20,
              right: 20,
              bottom: 25,
              child: Column(
                children: [
                  Text(
                    "Find Your Next\nFavorite Movie Here",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 36,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    "Get access to a huge library of movies"
                    "to suit all tastes. You will surely like it.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(text: 'Explore Now', onPressed: () {
                      context.go(AppRoutesName.discovermovies);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
