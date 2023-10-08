import 'package:flutter/material.dart';

class ThemeClass {
  Color primary = const Color(0xff81e6d9);
  Color primaryContainer = const Color(0xff005048);
  Color secondary = const Color(0xffb1ccc6);
  Color secondaryContainer = const Color(0xff334b47);
  Color error = const Color(0xffffb4ab);
  Color errorContainer = const Color(0xff93000a);
  Color background = const Color(0xff181c1c);
  Color outline = const Color(0xffb4c4c4);
  Color surface = const Color(0xff1b2424);
  Color text = const Color(0xffe0e3e1);
  Color caption = const Color(0xff899390);
  Color onPrimary = const Color(0xff003731);
  Color onPrimaryContainer = const Color(0xff92f4e5);
  Color onSecondary = const Color(0xff1c3531);
  Color onSecondaryContainer = const Color(0xffcce8e2);
  Color onError = const Color(0xff690005);
  Color onErrorContainer = const Color(0xffffb4ab);
  Color onBackground = const Color(0xffe0e3e1);
  Color onSurface = const Color(0xffe0e3e1);

  static ThemeData theme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: _themeClass.primary,
      primaryContainer: _themeClass.primaryContainer,
      secondary: _themeClass.secondary,
      secondaryContainer: _themeClass.secondaryContainer,
      error: _themeClass.error,
      errorContainer: _themeClass.errorContainer,
      background: _themeClass.background,
      outline: _themeClass.outline,
      surface: _themeClass.surface,
      onPrimary: _themeClass.onPrimary,
      onPrimaryContainer: _themeClass.onPrimaryContainer,
      onSecondary: _themeClass.onSecondary,
      onSecondaryContainer: _themeClass.onSecondaryContainer,
      onError: _themeClass.onError,
      onErrorContainer: _themeClass.onErrorContainer,
      onBackground: _themeClass.onBackground,
      onSurface: _themeClass.onSurface,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: _themeClass.text,
        fontSize: 38,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: _themeClass.text,
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: _themeClass.text,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: _themeClass.text,
        fontSize: 20,
      ),
      titleMedium: TextStyle(
        color: _themeClass.text,
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        color: _themeClass.text,
        fontSize: 12,
      ),
      bodyLarge: TextStyle(
        color: _themeClass.text,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        color: _themeClass.text,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: _themeClass.caption,
        fontSize: 12,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: _themeClass.primary,
      labelStyle: MaterialStateTextStyle.resolveWith(
        (states) {
          if (states.contains(MaterialState.focused)) {
            return TextStyle(color: _themeClass.primary);
          }
          return TextStyle(color: _themeClass.outline);
        },
      ),
      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
        (states) {
          if (states.contains(MaterialState.focused)) {
            return TextStyle(color: _themeClass.primary);
          }
          return TextStyle(color: _themeClass.outline);
        },
      ),
      prefixIconColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.focused)) {
            return _themeClass.primary;
          }
          return _themeClass.outline;
        },
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: _themeClass.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: _themeClass.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: _themeClass.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: _themeClass.error),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      foregroundColor: _themeClass.outline,
      backgroundColor: _themeClass.background,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _themeClass.surface,
      unselectedItemColor: _themeClass.outline,
    ),
    dividerTheme: DividerThemeData(
      space: 1,
      color: _themeClass.outline,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      circularTrackColor: _themeClass.text,
    ),
  );
}

ThemeClass _themeClass = ThemeClass();
