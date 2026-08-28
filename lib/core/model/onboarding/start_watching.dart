import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/core/widgets/outlinebotton.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartWatching extends StatelessWidget {
  const StartWatching({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Assets.images.onboarding6.image(fit: BoxFit.cover),
          ),

          Positioned.fill(
            child: Assets.images.shadow6.image(fit: BoxFit.cover),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Start Watching Now',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(height: 20),

                  CustomButton(text: 'Next', onPressed: () {
                    context.go(AppRoutesName.login);
                  }
                  ),
                  const SizedBox(height: 16),
                  OutlineButton(text: 'Back', onPressed: () {
                    context.go(AppRoutesName.rateReview);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
