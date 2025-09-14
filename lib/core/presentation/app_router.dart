import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/presentation/auth_guard.dart';
import 'package:movie_app/features/auth/presentation/screens/auth.dart';
import 'package:movie_app/features/home/presentation/screens/home_screen.dart';
import 'package:movie_app/features/movie/presentation/screens/movie_details_screen.dart';
import 'package:movie_app/features/movie/presentation/screens/movies_screen.dart';
import 'package:movie_app/features/search/presentation/screens/search_screen.dart';
import 'package:movie_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:movie_app/core/presentation/screens/navigation_screen.dart';
import 'package:movie_app/features/splash/presentation/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter({required this.authGuard});

  final AuthGuard authGuard;

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: SplashRoute.page, initial: true, path: '/'),
        AutoRoute(page: AuthRoute.page, path: '/auth'),
        AutoRoute(
          page: NavigationRoute.page,
          path: '/navigation',
          guards: <AutoRouteGuard>[authGuard],
          children: <AutoRoute>[
            AutoRoute(page: HomeRoute.page, path: 'home'),
            AutoRoute(page: MoviesRoute.page, path: 'movies'),
            AutoRoute(page: SearchRoute.page, path: 'search'),
            AutoRoute(page: SettingsRoute.page, path: 'settings'),
          ],
        ),
        AutoRoute(page: MovieDetailsRoute.page, path: '/movie-details'),
      ];
}
