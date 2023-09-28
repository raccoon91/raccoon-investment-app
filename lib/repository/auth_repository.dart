import 'dart:async';

import 'package:raccoon_investment/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  User? getUser() {
    try {
      final user = supabase.auth.currentUser;

      return user;
    } on PostgrestException catch (error) {
      throw PostgrestException(message: error.message);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<AuthResponse> postSignIn({
    required String email,
    required String password,
  }) async {
    try {
      final user = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return user;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> postSignOut() async {
    try {
      await supabase.auth.signOut();

      return true;
    } on AuthException catch (error) {
      throw AuthException(error.message);
    } catch (error) {
      throw Exception(error);
    }
  }
}
