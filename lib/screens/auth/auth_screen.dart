import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trexxo_mobility/screens/auth/login_screen.dart';
import 'package:trexxo_mobility/screens/auth/register_screen.dart';
import 'package:trexxo_mobility/widgets/custom_dividers.dart';
import 'package:trexxo_mobility/widgets/custom_text_buttons.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final brightness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo_name_column.png', width: 250),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Journey, ',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                  Text(
                    'Your Rules',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5555ff),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SocialLoginButtons(
                    icon: Brand(Brands.google),
                    label: 'Continue with Google',
                    onPressed: () {
                      // Handle Google login
                    },
                  ),
                  const SizedBox(height: 12),
                  SocialLoginButtons(
                    icon: Brand("assets\others\apple-icon.svg"),
                    label: 'Continue with Apple',
                    onPressed: () {
                      // Handle Apple login
                    },
                  ),
                  const SizedBox(height: 24),
                  buildDividerWithText('OR'),
                  const SizedBox(height: 16),
                  AuthButton(
                    label: 'Login',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ClickableTextSpanRow(
                text: "Don't have an account? ",
                actionText: "Register now!",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
