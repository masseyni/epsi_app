import 'package:flutter/material.dart';
import 'screens/auth/forgot_password_page.dart';
import 'screens/auth/reset_password_page.dart';
import 'screens/auth/login_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/forgot-password':
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case '/reset-password':
        final token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ResetPasswordPage(token: token),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}