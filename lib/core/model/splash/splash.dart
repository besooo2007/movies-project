import 'dart:async';

import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutesName.onboarding,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Assets.images.splashBackground.image()),
    );
  }
}
