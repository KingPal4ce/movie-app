import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/core/api_dio_client.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/themes/dark_mode.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/themes/light_mode.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/screens/navigation_screen.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/data/services/auth_service.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/blocs/auth_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/blocs/auth_state.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/repositories/auth_repo.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/repositories/auth_repo_impl.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/presentation/screens/auth.dart';
import 'package:flutter_intro_bootcamp_project/features/home/data/service/home_service.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/blocs/home_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/repositories/home_repo.dart';
import 'package:flutter_intro_bootcamp_project/features/home/domain/repositories/home_repo_impl.dart';
import 'package:nested/nested.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Dio dio = Dio();
    final ApiDioClient apiClient = ApiDioClient(dio);

    final AuthService authService = AuthService();
    final AuthRepo authRepo = AuthRepoImpl(authService);

    final HomeService homeService = HomeService(apiClient);
    final HomeRepo homeRepo = HomeRepoImpl(homeService);

    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        // Auth BLoC
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc(authRepo: authRepo)..checkAuth()),

        // Home BLoC
        BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc(homeRepo: homeRepo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.system,
        title: 'Movie App',
        home: BlocConsumer<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState authState) {
            // unauthenticated -> auth screen (login/register)
            if (authState is Unauthenticated) {
              return const AuthScreen();
            }

            // authenticated -> home screen
            if (authState is Authenticated) {
              return const NavigationScreen();
            }
            // loading..
            else {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }
          },

          // listen for errors..
          listener: (BuildContext context, AuthState state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
