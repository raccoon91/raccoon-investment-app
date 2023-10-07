import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:raccoon_investment/app.dart';
import 'package:raccoon_investment/db/drift.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';

final supabase = Supabase.instance.client;
late Drift drift;

var logger = Logger(
  printer: PrettyPrinter(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_API']!,
    anonKey: dotenv.env['SUPABASE_API_KEY']!,
    authFlowType: AuthFlowType.pkce,
  );

  drift = Drift();

  logger.t("Trace log");

  logger.d("Debug log");

  logger.i("Info log");

  logger.w("Warning log");

  logger.e("Error log", error: 'Test Error');

  runApp(App());
}
