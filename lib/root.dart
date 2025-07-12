import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/blocs/auth/auth_state.dart';
import 'package:trexxo_mobility/blocs/booking/booking_bloc.dart';
import 'package:trexxo_mobility/cubits/location_cubit.dart';
import 'package:trexxo_mobility/cubits/onboarding_cubit.dart';
import 'package:trexxo_mobility/cubits/ride_request_cubit.dart';
import 'package:trexxo_mobility/cubits/theme_cubit.dart';

import 'package:trexxo_mobility/screens/auth/auth_screen.dart';
import 'package:trexxo_mobility/screens/home/home_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/splash_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/welcome_screen.dart';

import 'package:trexxo_mobility/services/firebase_service.dart';

Widget buildRoot(
  FirebaseService firebaseService,
  ThemeCubit themeCubit,
  Widget myApp,
) {
  return RepositoryProvider.value(
    value: firebaseService,
    child: MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeCubit),
        BlocProvider(create: (_) => OnboardingCubit()),
        BlocProvider(create: (_) => LocationCubit()),
        BlocProvider(create: (_) => BookingBloc()),
        BlocProvider(create: (_) => RideRequestCubit()),
        BlocProvider(
          create:
              (context) =>
                  AuthBloc(firebaseService: context.read<FirebaseService>())
                    ..add(AppStarted()),
        ),
      ],
      child: myApp,
    ),
  );
}

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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (_showSplash) {
          return const SplashScreen();
        }
        final isFirstTime = context.select<OnboardingCubit, bool>(
          (cubit) => cubit.state,
        );

        if (authState is AuthInitial) {
          return const SplashScreen();
        }

        if (isFirstTime) {
          return const WelcomeScreen();
        } else if (authState is Authenticated) {
          return const HomeScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
