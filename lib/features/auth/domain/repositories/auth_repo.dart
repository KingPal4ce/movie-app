import 'package:movie_app/features/auth/data/models/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);

  Future<AppUser?> signInWithGoogle();

  Future<AppUser?> registerWithEmailPassword(String name, String email, String password);

  Future<void> logout();

  Future<AppUser?> getCurrentUser();
}
