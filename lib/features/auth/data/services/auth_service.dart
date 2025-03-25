import 'package:flutter_intro_bootcamp_project/features/auth/data/models/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(email: email, password: password);
      return response.user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      const String webClientId = '853198079561-2rp455uaqmn76q89cq65jeh7vfjgu685.apps.googleusercontent.com';
      const String iosClientId = '853198079561-lhmcknrtq0b4omuc4n33eeq0ijkm4igd.apps.googleusercontent.com';

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
        // Add these configurations
        signInOption: SignInOption.standard, // Always show account picker
        forceCodeForRefreshToken: true, // Optional but recommended
      );

      // Add this line to force account selection
      await googleSignIn.signOut(); // This clears any cached account selection

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

      // Rest of your existing code...
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (accessToken == null) throw 'No Access Token found.';
      if (idToken == null) throw 'No ID Token found.';

      final AuthResponse response = await supabase.auth.signInWithIdToken(provider: OAuthProvider.google, idToken: idToken, accessToken: accessToken);

      if (response.user != null) {
        final PostgrestMap? existingUser = await supabase.from('users').select().eq('uid', response.user!.id).maybeSingle();

        if (existingUser == null) {
          final AppUser user = AppUser(uid: response.user!.id, email: response.user!.email ?? googleUser.email, name: googleUser.displayName ?? '');
          await supabase.from('users').insert(user.toJson());
        }
      }

      return response.user;
    } catch (e) {
      throw Exception('Google login failed: ${e.toString()}');
    }
  }

  Future<User?> signUpWithEmailPassword(String name, String email, String password) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(email: email, password: password);

      AppUser user = AppUser(uid: response.user!.id, email: email, name: name);

      if (response.user != null) {
        await supabase.from('users').upsert(user.toJson());
      }
      return response.user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return supabase.auth.currentSession?.user;
  }
}
