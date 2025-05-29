import 'package:flutter/material.dart';
import 'package:trexxo_mobility/screens/auth/auth_screen.dart';
import 'package:trexxo_mobility/screens/auth/profile_setup_screen.dart';
import 'package:trexxo_mobility/screens/auth/reset_password.dart';
import 'package:trexxo_mobility/screens/auth/login_screen.dart';
import 'package:trexxo_mobility/screens/auth/register_screen.dart';
import 'package:trexxo_mobility/screens/home/home_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/onboarding_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/welcome_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  welcomeRoute: (context) => const WelcomeScreen(),
  onBoardRoute: (context) => const OnboardingScreen(),
  authRoute: (context) => const AuthScreen(),
  homeRoute: (context) => const HomeScreen(),
  loginRoute: (context) => const LoginScreen(),
  registerRoute: (context) => const RegisterScreen(),
  resetPassRoute: (context) => const ResetPasswordScreen(),
  profileSetupRoute: (context) => const ProfileSetupScreen(),
};

// routes
const welcomeRoute = '/welcome/';
const onBoardRoute = '/onboarding/';
const authRoute = '/auth/';
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

const String appLogo = "assets/images/logo.png";
const String appLogoColumn = "assets/images/logo_name_column.png";
const String appLogoRow = "assets/images/logo_name_horizontal.png";
