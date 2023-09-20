import 'dart:async';

import 'package:flutter/material.dart';
import 'package:raccoon_investment/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthStatus>();

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({required String email, required String password}) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      _controller.add(AuthStatus.authenticated);
    } catch (error) {
      const SnackBar(content: Text('Unexpected error occurred'));
    }
  }

  Future<void> logOut() async {
    try {
      await supabase.auth.signOut();

      _controller.add(AuthStatus.unauthenticated);
    } on AuthException catch (error) {
      SnackBar(content: Text(error.message));
    } catch (error) {
      const SnackBar(content: Text('Unexpected error occurred'));
    }
  }

  void dispose() => _controller.close();
}
