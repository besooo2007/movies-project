import 'package:app/core/routes/App_Routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.go(AppRoutesName.login);
      },
      child: const Text("Click here"),
    );
  }
}