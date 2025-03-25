import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/data/models/app_user.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/blocs/auth_state.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/repositories/auth_repo.dart';

class AuthBloc extends Cubit<AuthState> {
  AuthBloc({required this.authRepo}) : super(AuthInitial());
  final AuthRepo authRepo;
  AppUser? _currentUser;

  // check if the user is already authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // get current user
  AppUser? get currentUser => _currentUser;

  // login with email + pw
  Future<void> login(String email, String pw) async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.loginWithEmailPassword(email, pw);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError("$e"));
      emit(Unauthenticated());
    }
  }

  Future<void> googleLogin() async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.signInWithGoogle();

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
      rethrow; // Optional: if you want to handle the error in the UI as well
    }
  }

  // register with email + pw
  Future<void> register(String name, String email, String pw) async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.registerWithEmailPassword(name, email, pw);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError("$e"));
      emit(Unauthenticated());
    }
  }

  // logout
  Future<void> logout() async {
    authRepo.logout();
    emit(Unauthenticated());
  }
}
