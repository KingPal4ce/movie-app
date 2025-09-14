import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/presentation/app_router.dart';
import 'package:movie_app/features/auth/domain/blocs/auth_bloc.dart';
import 'package:movie_app/features/auth/domain/blocs/auth_states.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final AuthStates? authStates = router.navigatorKey.currentContext?.read<AuthBloc>().state;

    if (authStates is Authenticated) {
      resolver.next(true); // allow navigation
    } else {
      router.replace(const AuthRoute()); // redirect
    }
  }
}
