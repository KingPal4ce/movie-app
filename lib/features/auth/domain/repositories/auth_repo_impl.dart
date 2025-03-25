import 'package:flutter_intro_bootcamp_project/features/auth/data/models/app_user.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/data/services/auth_service.dart';
import 'package:flutter_intro_bootcamp_project/features/auth/domain/repositories/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._authService);
  final AuthService _authService;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    final User? user = await _authService.signInWithEmailPassword(email, password);
    if (user == null) return null;

    return AppUser(uid: user.id, email: user.email!, name: '');
  }

  @override
  Future<AppUser?> registerWithEmailPassword(String name, String email, String password) async {
    final User? user = await _authService.signUpWithEmailPassword(name, email, password);
    if (user == null) return null;

    return AppUser(uid: user.id, email: user.email!, name: name);
  }

  @override
  Future<void> logout() async {
    await _authService.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final User? user = await _authService.getCurrentUser();
    if (user == null) return null;

    return AppUser(uid: user.id, email: user.email!, name: '');
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      final User? user = await _authService.signInWithGoogle();
      if (user == null) return null;

      // Get the first matching user if multiple exist
      final List<dynamic> response = await _authService.supabase.from('users').select().eq('uid', user.id).limit(1); // Explicitly limit to 1 row

      final Map<String, dynamic>? userData = response.isNotEmpty ? response.first as Map<String, dynamic> : null;

      final String name = userData?['name'] ?? user.userMetadata?['full_name'] ?? user.userMetadata?['name'] ?? '';

      return AppUser(uid: user.id, email: user.email ?? '', name: name);
    } catch (e) {
      throw Exception('Error in AuthRepoImpl (signInWithGoogle): ${e.toString()}');
    }
  }
}
