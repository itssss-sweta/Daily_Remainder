import 'package:daily_remainder/config/routes/routes.dart';
import 'package:daily_remainder/screen1/page.dart';
import 'package:daily_remainder/screen2/regscreen.dart';
import 'package:daily_remainder/screen3/login.dart';
import 'package:daily_remainder/screen4/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? ongenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.getStarted:
        return MaterialPageRoute(
          builder: (context) => const GetStarted(),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterPage(),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
