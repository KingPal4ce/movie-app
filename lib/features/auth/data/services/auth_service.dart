import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/features/auth/data/models/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;
  final String webClientId = dotenv.env['WEB_CLIENT_ID'] ?? '';
  final String iosClientId = dotenv.env['IOS_CLIENT_ID'] ?? '';

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
      final GoogleSignIn googleSignIn = GoogleSignIn(clientId: iosClientId, serverClientId: webClientId);

      // reset selected email
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;

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
