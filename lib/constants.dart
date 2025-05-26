import 'package:flutter/material.dart';
import 'package:trexxo_mobility/screens/home/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  homeRoute: (context) => const HomeScreen(),
};

// routes
const homeRoute = '/home/';

// constants
class StringConstants {
  static const String appFullName = 'Trexxo Mobility';
  static const String appName = 'Trexxo';
}
