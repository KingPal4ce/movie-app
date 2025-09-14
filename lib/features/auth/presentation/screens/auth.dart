import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/presentation/screens/login_screen.dart';
import 'package:movie_app/features/auth/presentation/screens/register_screen.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // initially, show the login page
  bool showLoginPage = true;

  // toggle between pages
  void togglePages() => setState(() => showLoginPage = !showLoginPage);

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(togglePages: togglePages);
    } else {
      return RegisterScreen(togglePages: togglePages);
    }
  }
}
