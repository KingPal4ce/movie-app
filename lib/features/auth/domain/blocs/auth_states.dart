import 'package:flutter_intro_bootcamp_project/features/auth/data/models/app_user.dart';

abstract class AuthStates {}

// initial
class AuthInitial extends AuthStates {}

// loading
class AuthLoading extends AuthStates {}

// authenticated
class Authenticated extends AuthStates {
  Authenticated(this.user);
  final AppUser? user;
}

// unauthenticated
class Unauthenticated extends AuthStates {}

// errors
class AuthError extends AuthStates {
  AuthError(this.message);
  final String message;
}
