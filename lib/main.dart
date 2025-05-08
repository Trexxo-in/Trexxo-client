import 'package:flutter/material.dart';
import 'package:trexxo_cab_client/Screens/splash.dart';
import 'package:trexxo_cab_client/theme/dark.dart';
import 'package:trexxo_cab_client/theme/light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trexxo Rider App',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      theme:lighttheme(),
      darkTheme: dark_theme(),
      debugShowCheckedModeBanner: false,
      home: const Splash_Screen(),
    );
  }
}

