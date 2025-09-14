import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/core/presentation/app_router.dart';
import 'package:movie_app/features/auth/data/models/app_user.dart';
import 'package:movie_app/features/auth/domain/blocs/auth_bloc.dart';
import 'package:movie_app/features/auth/domain/blocs/auth_states.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthStates>(
      builder: (BuildContext context, AuthStates state) {
        state.maybeWhen(
          unauthenticated: () => context.router.replace(const AuthRoute()),
          authenticated: (AppUser? user) => context.router.replace(const NavigationRoute()),
          orElse: () {},
        );
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.local_movies, size: 150),
                const SizedBox(height: 50),
                Text("F I L M F L I X", style: GoogleFonts.poppins(fontSize: 38)),
              ],
            ),
          ),
        );
      },
    );
  }
}
