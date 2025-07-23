import 'package:auto_route/auto_route.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/auth_guard.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/presentation/screens/auth.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/screens/navigation_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter({required this.authGuard});

  final AuthGuard authGuard;

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: AuthRoute.page, initial: true),
    AutoRoute(page: NavigationRoute.page, guards: <AutoRouteGuard>[authGuard]),
  ];
}
