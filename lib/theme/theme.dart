import 'package:flutter/material.dart';

class ThemeClass {
  Color primary = const Color(0xff4FD1C5);
  Color secondary = const Color(0xffFF8B6A);
  Color accent = const Color(0xffFFD2BB);

  Color background = const Color(0xff1C1C1C);

  static ThemeData theme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: _themeClass.primary,
      secondary: _themeClass.secondary,
      background: _themeClass.background,
    ),
  );
}

ThemeClass _themeClass = ThemeClass();
