import 'package:flutter/material.dart';
import 'package:trexxo_mobility/screens/auth/profile_setup_screen.dart';
import 'package:trexxo_mobility/screens/auth/reset_password.dart';
import 'package:trexxo_mobility/screens/auth/login_screen.dart';
import 'package:trexxo_mobility/screens/auth/register_screen.dart';
import 'package:trexxo_mobility/screens/home/home_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  homeRoute: (context) => const HomeScreen(),
  loginRoute: (context) => const LoginScreen(),
  registerRoute: (context) => const RegisterScreen(),
  resetPassRoute: (context) => const ResetPasswordScreen(),
  profileSetupRoute: (context) => const ProfileSetupScreen(),
};

// routes
const homeRoute = '/home/';
const loginRoute = '/login/';
const registerRoute = '/register/';
const resetPassRoute = '/reset-password/';
const profileSetupRoute = '/profile-setup/';

// constants
class StringConstants {
  static const String appFullName = 'Trexxo Mobility';
  static const String appName = 'Trexxo';
}
