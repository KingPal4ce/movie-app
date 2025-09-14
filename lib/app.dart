import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/data/api_dio_client.dart';
import 'package:movie_app/core/presentation/app_router.dart';
import 'package:movie_app/core/presentation/auth_guard.dart';
import 'package:movie_app/core/presentation/themes/dark_mode.dart';
import 'package:movie_app/core/presentation/themes/light_mode.dart';
import 'package:movie_app/features/auth/data/services/auth_service.dart';
import 'package:movie_app/features/auth/domain/blocs/auth_bloc.dart';
import 'package:movie_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:movie_app/features/auth/domain/repositories/auth_repo_impl.dart';
import 'package:movie_app/features/home/data/services/home_service.dart';
import 'package:movie_app/features/home/domain/blocs/home_bloc.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo.dart';
import 'package:movie_app/features/home/domain/repositories/home_repo_impl.dart';
import 'package:movie_app/features/movie/data/services/movie_service.dart';
import 'package:movie_app/features/movie/domain/blocs/movie_bloc.dart';
import 'package:movie_app/features/movie/domain/blocs/movie_details_bloc.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_details_repo.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_details_repo_impl.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repo.dart';
import 'package:movie_app/features/movie/domain/repositories/movie_repo_impl.dart';
import 'package:movie_app/features/search/data/services/search_service.dart';
import 'package:movie_app/features/search/domain/blocs/search_bloc.dart';
import 'package:movie_app/features/search/domain/repositories/search_repo.dart';
import 'package:movie_app/features/search/domain/repositories/search_repo_impl.dart';
import 'package:nested/nested.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthGuard authGuard = AuthGuard();
    final AppRouter appRouter = AppRouter(authGuard: authGuard);

    final Dio dio = Dio();
    final ApiDioClient apiClient = ApiDioClient(dio);

    final AuthService authService = AuthService();
    final AuthRepo authRepo = AuthRepoImpl(authService);

    final HomeService homeService = HomeService(apiClient);
    final HomeRepo homeRepo = HomeRepoImpl(homeService);

    final MovieService movieService = MovieService(apiClient);
    final MovieRepo movieRepo = MovieRepoImpl(movieService);
    final MovieDetailsRepo movieDetailsRepo = MovieDetailsRepoImpl(movieService);

    final SearchService searchService = SearchService(apiClient);
    final SearchRepo searchRepo = SearchRepoImpl(searchService: searchService);

    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        // Auth BLoC
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc(authRepo: authRepo)..checkAuth()),

        // Home BLoC
        BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc(homeRepo: homeRepo)),

        // Movie BLoC
        BlocProvider<MovieBloc>(create: (BuildContext context) => MovieBloc(movieRepo: movieRepo)),

        // Movie Details BLoC
        BlocProvider<MovieDetailsBloc>(create: (BuildContext context) => MovieDetailsBloc(movieDetailsRepo: movieDetailsRepo)),

        // Search BLoC
        BlocProvider<SearchBloc>(create: (BuildContext context) => SearchBloc(searchRepo: searchRepo)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.system,
        title: 'Movie App',
        routerConfig: appRouter.config(),
      ),
    );
  }
}
