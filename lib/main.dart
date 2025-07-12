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
import 'cubits/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  HydratedBloc.storage = storage;

  final firebaseService = FirebaseService();
  final themeCubit = ThemeCubit();

  runApp(buildRoot(firebaseService, themeCubit, const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      buildWhen: (previous, current) => previous != current,
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
