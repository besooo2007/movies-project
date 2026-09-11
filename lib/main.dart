import 'package:app/core/model/splash/splash.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/routes/App_routes_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(scaffoldBackgroundColor: Colors.black),

      initialRoute: AppRoutesName.home,
      onGenerateRoute: AppRoutesManager.getRoute,
    );
  }
}
