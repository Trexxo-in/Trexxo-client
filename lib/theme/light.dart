import 'package:flutter/material.dart';

lighttheme() {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    fontFamily: 'Oxanium',
    primaryColor: const Color(0xFF3797EF),
    cardColor: const Color(0xFF000000),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 22,
        color: Color(0xff000000),
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xff5455FF),
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w800,
      ),
      bodyMedium:TextStyle(
         fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      )
    ),
    highlightColor: const Color(0xFFDCDCDD),
    canvasColor: const Color(0xFFFAFAFA),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0x03fafafa),
      unselectedItemColor: Colors.black,
      selectedItemColor: Color(0xFF3797EF),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor:
          Color(0xFFFAFAFA), // Set AppBar background color explicitly
      foregroundColor: Colors.black, // Set text/icon color
    ),
  );
}
