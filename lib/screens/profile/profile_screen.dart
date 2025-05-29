import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/cubits/theme_cubit.dart';
import 'package:trexxo_mobility/widgets/custom_text_buttons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark =
        themeMode == ThemeMode.system
            ? brightness == Brightness.dark
            : themeMode == ThemeMode.dark;

    final user = context.read<AuthBloc>().currentUser;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
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
              ],
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Name: ${user?.name}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Mobile: ${user?.mobile}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Email: ${user?.email}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              AuthButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LoggedOut());
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                label: 'Logout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
