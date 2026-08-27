import 'package:app/core/model/onboarding/onboarding.dart';
import 'package:app/core/model/splash/splash.dart';
import 'package:app/core/routes/app_routes_name.dart';
import 'package:app/features/auth/presention/login/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesName.splash,

    routes: [
      GoRoute(
        path: AppRoutesName.splash,
        builder: (context, state) => const Splash(),
      ),

      GoRoute(
        path: AppRoutesName.onboarding,
        builder: (context, state) => const Onboarding(),
      ),

      GoRoute(
        path: AppRoutesName.login,
        builder: (context, state) => const Login(),
      ),
    ],

    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Route Not Found'),
      ),
    ),
  );
}