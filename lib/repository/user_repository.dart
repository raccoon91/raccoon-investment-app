import 'package:raccoon_investment/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  User? _user;

  User? getUser() {
    if (_user != null) return _user;

    try {
      _user = supabase.auth.currentUser;
    } on PostgrestException catch (error) {
      print(error.message);
    } catch (error) {
      print(error);
    }

    return _user;
  }
}
