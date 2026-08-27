import 'package:app/core/model/login/login.dart';
import 'package:app/core/model/onboarding/onboarding.dart';
import 'package:app/core/model/splash/splash.dart';
import 'package:app/feature/Register/presentation/ui/register_view.dart';
import 'package:app/feature/forget%20password/presentation/ui/forget_password_view.dart';
import 'package:flutter/material.dart';
import 'package:app/core/routes/App_Routes_name.dart';

class AppRoutesManager {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.splash:
        return MaterialPageRoute(builder: (_) => const Splash());

      case AppRoutesName.onboarding:
        return MaterialPageRoute(builder: (_) => const Onboarding());

      case AppRoutesName.login:
        return MaterialPageRoute(builder: (_) => const Login());

      case AppRoutesName.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case AppRoutesName.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetView());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route Not Found'))),
        );
    }
  }
}
