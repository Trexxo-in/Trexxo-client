import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xFF5555FF);
const backgroundLight = Color(0xFFF5F5F5);
const backgroundDark = Color(0xFF121212);
String? fontFam = GoogleFonts.rubik().fontFamily;

ThemeData lightTheme = ThemeData(
  fontFamily: fontFam,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundLight,

  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: primaryColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.black87),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      iconColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black87),
    headlineSmall: TextStyle(color: Colors.black87),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      foregroundColor: WidgetStatePropertyAll(
        const Color.fromRGBO(255, 255, 255, 1),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Colors.black),
      side: WidgetStatePropertyAll(BorderSide(color: Colors.black)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(),
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: fontFam,
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundDark,
  colorScheme: ColorScheme.dark(
    primary: primaryColor,
    secondary: primaryColor,
    background: backgroundDark,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      iconColor: WidgetStatePropertyAll(Colors.black87),
      iconSize: WidgetStatePropertyAll(24.0),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white70),
    headlineSmall: TextStyle(color: Colors.white),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      side: WidgetStatePropertyAll(BorderSide(color: Colors.white)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E1E1E),
    prefixIconColor: Colors.white70,
    suffixIconColor: Colors.white70,
    labelStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(),
  ),
);
