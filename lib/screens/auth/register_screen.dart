import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/services/auth_service.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/widgets/custom_dividers.dart';
import 'package:trexxo_mobility/widgets/custom_snackbar.dart';
import 'package:trexxo_mobility/widgets/custom_text_buttons.dart';
import 'package:trexxo_mobility/widgets/custom_text_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool loading = false;
  bool obscureText = true;
  String? error;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _register(AuthService authService) async {
    setState(() {
      loading = true;
    });

    try {
      final user = await authService.register(
        email: _emailController.text.trim(),
        password: _passController.text,
      );

      if (user != null) {
        context.read<AuthBloc>().add(LoggedIn());
        Navigator.pop(context);
        showSnackBar(context, 'Registration successful!');
      }
    } catch (e) {
      showSnackBar(context, e.toString(), error: true);
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Register Your Account',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Email Field
            CustomTextField(
              label: 'Email',
              hintText: 'Enter your Email Address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 16),

            // Password Field
            CustomTextField(
              label: 'Password',
              hintText: 'Enter your Password',
              controller: _passController,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: Icons.lock,
              obscureText: obscureText,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.remove_red_eye_outlined,
                ),
                onPressed: () {
                  setState(() => obscureText = !obscureText);
                },
              ),
            ),
            const SizedBox(height: 16),

            // Register Button
            AuthButton(
              onPressed: () => _register(authService),
              label: loading ? 'Registering...' : 'Register',
            ),
            const SizedBox(height: 16),

            // Forgot Password (optional for register, but kept if you want)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClickableTextSpanRow(
                  text: 'Already have an account? ',
                  actionText: 'Login',
                  onTap: () {
                    Navigator.pushReplacementNamed(context, loginRoute);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Divider
            buildDividerWithText('OR'),
            const SizedBox(height: 16),

            // Social Register Buttons
            SocialLoginButtons(
              icon: Brand(Brands.google),
              label: 'Continue with Google',
              onPressed: () {
                // Google register logic
              },
            ),
            const SizedBox(height: 12),
            SocialLoginButtons(
              icon: Brand(Brands.apple_brand),
              label: 'Continue with Apple',
              onPressed: () {
                // Apple register logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
