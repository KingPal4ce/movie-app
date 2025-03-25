import 'package:flutter_intro_bootcamp_project/features/auth/data/models/app_user.dart';

abstract class AuthState {}

// initial
class AuthInitial extends AuthState {}

// loading
class AuthLoading extends AuthState {}

// authenticated
class Authenticated extends AuthState {
  Authenticated(this.user);
  final AppUser? user;
}

// unauthenticated
class Unauthenticated extends AuthState {}

// errors
class AuthError extends AuthState {
  AuthError(this.message);
  final String message;
}
