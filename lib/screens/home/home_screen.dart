import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/cubits/theme_cubit.dart';
import 'package:trexxo_mobility/screens/profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark =
        themeMode == ThemeMode.system
            ? brightness == Brightness.dark
            : themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          Row(
            children: [
              const Icon(Icons.light_mode),
              Switch(
                value: isDark,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme(value);
                },
              ),
              const Icon(Icons.dark_mode),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    ),
              ),
            ],
          ),
        ],
      ),
      body: const Center(child: Text('Welcome to Home')),
    );
  }
}
