import 'package:auto_route/auto_route.dart';
import 'package:flutter_intro_bootcamp_project/core/presentation/app_router.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/blocs/auth_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/blocs/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(router.navigatorKey.currentContext!);

    // Check current auth state
    if (authBloc.state is Authenticated) {
      // If authenticated, allow navigation
      resolver.next(true);
    } else if (authBloc.state is Unauthenticated) {
      // If not authenticated, redirect to auth screen
      router.replace(const AuthRoute());
      resolver.next(false);
    } else {
      // If state is loading or unknown, wait for the first emission
      final Stream<AuthStates> stream = authBloc.stream;
      await for (final AuthStates state in stream) {
        if (state is Authenticated) {
          resolver.next(true);
          break;
        } else if (state is Unauthenticated) {
          router.replace(const AuthRoute());
          resolver.next(false);
          break;
        }
      }
    }
  }
}
