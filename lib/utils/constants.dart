import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trexxo_mobility/screens/auth/auth_screen.dart';
import 'package:trexxo_mobility/screens/auth/profile_setup_screen.dart';
import 'package:trexxo_mobility/screens/auth/reset_password.dart';
import 'package:trexxo_mobility/screens/auth/login_screen.dart';
import 'package:trexxo_mobility/screens/auth/register_screen.dart';
import 'package:trexxo_mobility/screens/home/home_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/onboarding_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/splash_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/welcome_screen.dart';
import 'package:trexxo_mobility/screens/profile/profile_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  splashRoute: (context) => const SplashScreen(),
  welcomeRoute: (context) => const WelcomeScreen(),
  onBoardRoute: (context) => const OnboardingScreen(),
  authRoute: (context) => const AuthScreen(),
  loginRoute: (context) => const LoginScreen(),
  registerRoute: (context) => const RegisterScreen(),
  resetPassRoute: (context) => const ResetPasswordScreen(),
  profileSetupRoute: (context) => const ProfileSetupScreen(),

  homeRoute: (context) => const HomeScreen(),
  profileRoute: (context) => ProfileScreen(),
};

// routes
const splashRoute = '/splash/';
const welcomeRoute = '/welcome/';
const onBoardRoute = '/onboarding/';
const authRoute = '/auth/';
const loginRoute = '/login/';
const registerRoute = '/register/';
const resetPassRoute = '/reset-password/';
const profileSetupRoute = '/profile-setup/';

const homeRoute = '/home/';
const profileRoute = '/profile/';

// constants
class StringConstants {
  static const String appFullName = 'Trexxo Mobility';
  static const String appName = 'Trexxo';
}

const String appLogo = "assets/app/logo.png";
const String appName = "assets/app/app_name.png";
const String appLogoColumn = "assets/app/logo_name_column.png";
const String appLogoRow = "assets/app/logo_name_horizontal.png";

const LatLng defaultLocation = LatLng(22.4800054, 88.3447443); // Kolkata, India
