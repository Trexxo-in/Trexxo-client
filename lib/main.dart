import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:trexxo_mobility/root.dart';
import 'package:trexxo_mobility/services/firebase_service.dart';
import 'package:trexxo_mobility/utils/theme.dart';

import 'firebase_options.dart';
import 'utils/constants.dart';

import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/blocs/booking/booking_bloc.dart';
import 'package:trexxo_mobility/cubits/location_cubit.dart';
import 'package:trexxo_mobility/cubits/onboarding_cubit.dart';
import 'package:trexxo_mobility/cubits/ride_request_cubit.dart';
import 'cubits/theme_cubit.dart';

void main() async {
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
    RepositoryProvider.value(
      value: firebaseService,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
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
          home: const RootInitializer(),
        );
      },
    );
  }
}
