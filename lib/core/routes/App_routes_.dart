import 'package:app/core/model/onboarding/ExploreAllGenres.dart';
import 'package:app/core/model/onboarding/onboarding.dart';
import 'package:app/core/model/onboarding/discovermovies.dart';
import 'package:app/core/model/splash/splash.dart';
import 'package:app/core/routes/app_routes_name.dart';
import 'package:app/features/auth/presention/forgetpassword/forget_password_view.dart';
import 'package:app/features/auth/presention/login/login.dart';
import 'package:app/core/model/onboarding/creat_watch_list.dart';
import 'package:app/core/model/onboarding/rate_review.dart';
import 'package:app/core/model/onboarding/start_watching.dart';
import 'package:app/features/auth/presention/register/register_view.dart';
import 'package:app/features/auth/presention/profile/presention/update_profile/update_profile_view.dart';
import 'package:app/features/browser/browse tab/presentation/ui/browse_view.dart';
import 'package:app/features/home_api/presnation/bloc/ui/layout.dart';
import 'package:app/features/movie_deatils/presntation/uii/movie_details_view.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesName.splash,

    routes: [
      // ============================================================
      // SPLASH
      // ============================================================

      GoRoute(
        path: AppRoutesName.splash,
        builder: (context, state) {
          return const Splash();
        },
      ),

      // ============================================================
      // ONBOARDING
      // ============================================================

      GoRoute(
        path: AppRoutesName.onboarding,
        builder: (context, state) {
          return const Onboarding();
        },
      ),

      // ============================================================
      // DISCOVER MOVIES
      // ============================================================

      GoRoute(
        path: AppRoutesName.discovermovies,
        builder: (context, state) {
          return const Discovermovies();
        },
      ),

      // ============================================================
      // EXPLORE ALL GENRES
      // ============================================================

      GoRoute(
        path: AppRoutesName.exploreAllGenres,
        builder: (context, state) {
          return const ExploreAllGenres();
        },
      ),

      // ============================================================
      // CREATE WATCH LIST
      // ============================================================

      GoRoute(
        path: AppRoutesName.createWatchList,
        builder: (context, state) {
          return const CreateWatchListsView();
        },
      ),

      // ============================================================
      // RATE REVIEW
      // ============================================================

      GoRoute(
        path: AppRoutesName.rateReview,
        builder: (context, state) {
          return const RateReview();
        },
      ),

      // ============================================================
      // START WATCHING
      // ============================================================

      GoRoute(
        path: AppRoutesName.startWatching,
        builder: (context, state) {
          return const StartWatching();
        },
      ),

      // ============================================================
      // LOGIN
      // ============================================================

      GoRoute(
        path: AppRoutesName.login,
        builder: (context, state) {
          return const Login();
        },
      ),

      // ============================================================
      // REGISTER
      // ============================================================

      GoRoute(
        path: AppRoutesName.register,
        builder: (context, state) {
          return const RegisterView();
        },
      ),

      // ============================================================
      // FORGET PASSWORD
      // ============================================================

      GoRoute(
        path: AppRoutesName.forgetPassword,
        builder: (context, state) {
          return const ForgetView();
        },
      ),

      // ============================================================
      // UPDATE PROFILE
      // ============================================================

      GoRoute(
        path: AppRoutesName.updateProfile,
        builder: (context, state) {
          return const UpdateProfileView();
        },
      ),

      // ============================================================
      // HOME
      // ============================================================

      GoRoute(
        path: AppRoutesName.home,
        builder: (context, state) {
          return const MainLayout();
        },
      ),

      // ============================================================
      // BROWSE
      // ============================================================

      GoRoute(
        path: AppRoutesName.BrowseView,
        builder: (context, state) {
          return const BrowseView();
        },
      ),

      // ============================================================
      // MOVIE DETAILS
      // ============================================================

      GoRoute(
        path: '${AppRoutesName.movieDetails}/:movieId',

        builder: (context, state) {
          final movieId = int.parse(
            state.pathParameters['movieId']!,
          );

          return MovieDetailsView(
            movieId: movieId,
          );
        },
      ),
    ],

    // ============================================================
    // ERROR
    // ============================================================

    errorBuilder: (context, state) {
      return const Scaffold(
        body: Center(
          child: Text(
            'Route Not Found',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    },
  );
}