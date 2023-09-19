import 'package:flutter/material.dart';
import 'package:raccoon_investment/src/screens/account_page.dart';
import 'package:raccoon_investment/src/screens/home_screen.dart';
import 'package:raccoon_investment/src/screens/login_page.dart';
import 'package:raccoon_investment/src/screens/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raccoon Investment',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.teal,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
        '/account': (_) => const AccountScreen(),
      },
    );
  }
}
