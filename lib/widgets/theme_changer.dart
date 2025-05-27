import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/cubits/theme_cubit.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<ThemeCubit>().state;

    return DropdownButton<ThemeMode>(
      value: currentTheme,
      items: const [
        DropdownMenuItem(value: ThemeMode.system, child: Text("System")),
        DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
        DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
      ],
      onChanged: (themeMode) {
        if (themeMode != null) {
          context.read<ThemeCubit>().emit(themeMode);
        }
      },
    );
  }
}
