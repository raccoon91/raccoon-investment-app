import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:raccoon_investment/app.dart';
import 'package:raccoon_investment/db/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
late Drift drift;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_API']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
    authFlowType: AuthFlowType.pkce,
  );

  drift = Drift();

  runApp(App());
}
