import 'package:flutter/material.dart';
import 'package:raccoon_investment/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  User? _user;

  User? getUser() {
    if (_user != null) return _user;

    try {
      _user = supabase.auth.currentUser;
    } on PostgrestException catch (error) {
      SnackBar(content: Text(error.message));
    } catch (error) {
      const SnackBar(content: Text('Unexpected error occurred'));
    }

    return _user;
  }
}
