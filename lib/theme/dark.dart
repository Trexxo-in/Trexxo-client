import 'package:flutter/material.dart';

ThemeData dark_theme() => ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.dark,
      fontFamily: "Oxanium",
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0x1A000000),
        unselectedItemColor: Colors.white,
        selectedItemColor: Color(0xFF3797EF),
      ),
      highlightColor: const Color(0xFF262626),
      primaryColor:
          const Color(0xFF3797EF), // Ensures the AppBar uses the primary color
      cardColor: const Color(0xFFFFFFFF),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 22,
          color: Color(0xffffffff),
        ),
        
        displayMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(0xFFB388FF),

        ),
        bodyMedium:TextStyle(
         fontSize: 18,
         color: Colors.white,

        fontWeight: FontWeight.w400,
      ),
          labelMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFFF9F9F9),
            fontWeight: FontWeight.w800,
          )
      ),
      canvasColor: const Color(0xFF07020F),
      appBarTheme: const AppBarTheme(
        backgroundColor:
        Color(0xFF121212), // Set AppBar background color explicitly
        foregroundColor: Colors.white, // Set text/icon color
      ),
    );
