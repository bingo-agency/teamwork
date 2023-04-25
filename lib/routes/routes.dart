import 'package:flutter/material.dart';
import 'package:team_work/pages/home/home.dart';
import 'package:team_work/pages/auth/login.dart';
import 'package:team_work/pages/splash/splash.dart';

class RouteManager {
  static const String splashPage = '/';
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(
          builder: (context) => const Splash(),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      default:
        throw const FormatException('Route not found, Check routes again');
    }
  }
}
