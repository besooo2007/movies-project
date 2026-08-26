import 'package:app/core/routes/App_Routes_name.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutesName.login);
      },
      child: Text("clik here"),
    );
  }
}
