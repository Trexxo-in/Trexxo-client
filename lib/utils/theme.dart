import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// --- Color Constants ---
const primaryColor = Color(0xFF5555FF);
const backgroundLight = Color(0xFFF5F5F5);
const backgroundDark = Color(0xFF121212);

/// Font Family using Google Fonts
String? fontFam = GoogleFonts.rubik().fontFamily;

/// --- Light Theme Configuration ---
ThemeData lightTheme = ThemeData(
  fontFamily: fontFam,
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundLight,

  // Global page transition animations
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
    },
  ),

  // Color scheme
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: primaryColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),

  // Icon styles
  iconTheme: const IconThemeData(color: Colors.black87),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      iconColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),

  // AppBar styling
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.black,
  ),

  // Text styling
  // textTheme: const TextTheme(
  //   bodyMedium: TextStyle(color: Colors.black87),
  //   headlineSmall: TextStyle(color: Colors.black87),
  // ),

  // Filled buttons
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),

  // Outlined buttons
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Colors.black),
      side: WidgetStatePropertyAll(BorderSide(color: Colors.black)),
    ),
  ),

  // Input fields styling
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    labelStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(),
  ),
);

/// --- Dark Theme Configuration ---
ThemeData darkTheme = ThemeData(
  fontFamily: fontFam,
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundDark,

  // Global page transition animations
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
    },
  ),

  // Color scheme
  colorScheme: ColorScheme.dark(
    primary: primaryColor,
    secondary: primaryColor,
    background: backgroundDark,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),

  // Icon button styling
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      iconColor: WidgetStatePropertyAll(Colors.black87),
      iconSize: WidgetStatePropertyAll(24.0),
    ),
  ),

  // AppBar styling
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white,
  ),

  // Text styling
  // textTheme: const TextTheme(
  //   bodyMedium: TextStyle(color: Colors.white70),
  //   headlineSmall: TextStyle(color: Colors.white),
  // ),

  // Filled buttons
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(primaryColor),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    ),
  ),

  // Outlined buttons
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      side: WidgetStatePropertyAll(BorderSide(color: Colors.white)),
    ),
  ),

  // Input fields styling
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF1E1E1E),
    prefixIconColor: Colors.white70,
    suffixIconColor: Colors.white70,
    labelStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(),
  ),
);
