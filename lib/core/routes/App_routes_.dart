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

import 'package:app/features/home_api/presnation/bloc/ui/layout.dart';
import 'package:app/features/profile/ui/profile_view.dart';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../features/movie_deatils/presntation/uii/movie_details_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesName.splash,

    routes: [
      GoRoute(
        path: AppRoutesName.splash,

        builder: (context, state) => const ProfileView(),
      ),

      GoRoute(
        path: AppRoutesName.onboarding,

        builder: (context, state) => const Onboarding(),
      ),

      GoRoute(
        path: AppRoutesName.discovermovies,

        builder: (context, state) => const Discovermovies(),
      ),

      GoRoute(
        path: AppRoutesName.exploreAllGenres,

        builder: (context, state) => const ExploreAllGenres(),
      ),

      GoRoute(
        path: AppRoutesName.createWatchList,

        builder: (context, state) => const CreateWatchListsView(),
      ),

      GoRoute(
        path: AppRoutesName.rateReview,

        builder: (context, state) => const RateReview(),
      ),

      GoRoute(
        path: AppRoutesName.startWatching,

        builder: (context, state) => const StartWatching(),
      ),

      GoRoute(
        path: AppRoutesName.login,

        builder: (context, state) => const Login(),
      ),

      GoRoute(
        path: AppRoutesName.register,

        builder: (context, state) => const RegisterView(),
      ),

      GoRoute(
        path: AppRoutesName.forgetPassword,

        builder: (context, state) => const ForgetView(),
      ),

      GoRoute(
        path: AppRoutesName.updateProfile,

        builder: (context, state) => const UpdateProfileView(),
      ),

      GoRoute(
        path: AppRoutesName.home,

        builder: (context, state) => const MainLayout(),
      ),
      GoRoute(  
        path: AppRoutesName.profile,
        builder: (context, state) => const ProfileView(),
      ),

      // Movie Details
      GoRoute(
        path: AppRoutesName.movieDetails,

        builder: (context, state) {
          final movieId = int.parse(state.pathParameters['movieId']!);

          return MovieDetailsView(movieId: movieId);
        },
      ),
    ],

    errorBuilder: (context, state) {
      return const Scaffold(body: Center(child: Text('Route Not Found')));
    },
  );
}
