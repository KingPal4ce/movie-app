import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/auth/data/models/app_user.dart';
import 'package:movie_app/features/auth/domain/blocs/auth_states.dart';
import 'package:movie_app/features/auth/domain/repositories/auth_repo.dart';

class AuthBloc extends Cubit<AuthStates> {
  AuthBloc({required this.authRepo}) : super(AuthStates.initial());
  final AuthRepo authRepo;
  AppUser? _currentUser;

  // check if the user is already authenticated
  void checkAuth() async {
    emit(AuthStates.loading());
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(AuthStates.authenticated(user));
    } else {
      emit(AuthStates.unauthenticated());
    }
  }

  // get current user
  AppUser? get currentUser => _currentUser;

  // login with email + pw
  Future<void> login(String email, String pw) async {
    try {
      emit(AuthStates.loading());
      final AppUser? user = await authRepo.loginWithEmailPassword(email, pw);

      if (user != null) {
        _currentUser = user;
        emit(AuthStates.authenticated(user));
      } else {
        emit(AuthStates.unauthenticated());
      }
    } catch (e) {
      emit(AuthStates.error("$e"));
      emit(AuthStates.unauthenticated());
    }
  }

  Future<void> googleLogin() async {
    try {
      emit(AuthStates.loading());
      final AppUser? user = await authRepo.signInWithGoogle();

      if (user != null) {
        _currentUser = user;
        emit(AuthStates.authenticated(user));
      } else {
        emit(AuthStates.unauthenticated());
      }
    } catch (e) {
      emit(AuthStates.error(e.toString()));
      emit(AuthStates.unauthenticated());
      rethrow;
    }
  }

  // register with email + pw
  Future<void> register(String name, String email, String pw) async {
    try {
      emit(AuthStates.loading());
      final AppUser? user = await authRepo.registerWithEmailPassword(name, email, pw);

      if (user != null) {
        _currentUser = user;
        emit(AuthStates.authenticated(user));
      } else {
        emit(AuthStates.unauthenticated());
      }
    } catch (e) {
      emit(AuthStates.error("$e"));
      emit(AuthStates.unauthenticated());
    }
  }

  // logout
  Future<void> logout() async {
    authRepo.logout();
    emit(AuthStates.unauthenticated());
  }
}
