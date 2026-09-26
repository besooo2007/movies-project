import 'package:app/core/routes/App_routes_.dart';

import 'package:app/features/auth/di/injection.dart';
import 'package:app/features/home_api/di/injiction.dart';
import 'package:app/features/movie_deatils/di/injection.dart';
import 'package:app/features/profile_api/di/di_profile.dart';
import 'package:app/features/search/di/search_injection.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupAuthInjection();
  setupHomeInjection();
  setupMovieDetailsInjection();
  setupProfileInjection();
  setupSearchInjection();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),

      routerConfig: AppRouter.router,
    );
  }
}