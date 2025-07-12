import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_state.dart';
import 'package:trexxo_mobility/cubits/onboarding_cubit.dart';
import 'package:trexxo_mobility/screens/auth/auth_screen.dart';
import 'package:trexxo_mobility/screens/home/home_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/splash_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/welcome_screen.dart';

class RootInitializer extends StatefulWidget {
  const RootInitializer({super.key});

  @override
  State<RootInitializer> createState() => _RootInitializerState();
}

class _RootInitializerState extends State<RootInitializer> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSplash = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return const SplashScreen();
    }

    final isFirstTime = context.watch<OnboardingCubit>().state;
    if (isFirstTime) {
      return WelcomeScreen();
    } else {
      final authState = context.watch<AuthBloc>().state;
      if (authState is Authenticated) {
        return const HomeScreen();
      } else if (authState is Unauthenticated) {
        return const AuthScreen();
      } else {
        return const SplashScreen();
      }
    }
  }
}
