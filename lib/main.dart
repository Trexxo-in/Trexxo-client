import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/blocs/auth/auth_state.dart';
import 'package:trexxo_mobility/blocs/booking/booking_bloc.dart';
import 'package:trexxo_mobility/cubits/onboarding_cubit.dart';
import 'package:trexxo_mobility/screens/auth/auth_screen.dart';
import 'package:trexxo_mobility/screens/home/home_screen.dart';
import 'package:trexxo_mobility/screens/onboarding/welcome_screen.dart';
import 'package:trexxo_mobility/services/firebase_service.dart';
import 'package:trexxo_mobility/utils/theme.dart';
import 'package:trexxo_mobility/widgets/custom_laoder.dart';

import 'firebase_options.dart';
import 'utils/constants.dart';
import 'cubits/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  HydratedBloc.storage = storage;

  final firebaseService = FirebaseService();

  runApp(
    RepositoryProvider<FirebaseService>(
      create: (_) => firebaseService,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => OnboardingCubit()),
          BlocProvider(
            create:
                (context) =>
                    AuthBloc(firebaseService: context.read<FirebaseService>())
                      ..add(AppStarted()),
          ),
          BlocProvider<BookingBloc>(create: (context) => BookingBloc()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: StringConstants.appFullName,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          routes: routes,
          home: BlocBuilder<OnboardingCubit, bool>(
            builder: (context, isFirstTime) {
              if (isFirstTime) {
                return WelcomeScreen();
              } else {
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return const HomeScreen();
                    } else if (state is Unauthenticated) {
                      return const AuthScreen();
                    }
                    return const CustomLoader();
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
