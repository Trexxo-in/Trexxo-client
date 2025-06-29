import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/services/firebase_service.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/utils/validators.dart';
import 'package:trexxo_mobility/widgets/custom_dividers.dart';
import 'package:trexxo_mobility/widgets/custom_icon_buttons.dart';
import 'package:trexxo_mobility/widgets/custom_laoder.dart';
import 'package:trexxo_mobility/widgets/custom_snackbar.dart';
import 'package:trexxo_mobility/widgets/custom_text_buttons.dart';
import 'package:trexxo_mobility/widgets/custom_text_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  void _login(FirebaseService firebaseService) async {
    final email = _emailController.text.trim();
    final password = _passController.text;

    final emailError = emailValidator(email);
    if (emailError != null) {
      showSnackBar(context, emailError, error: true);
      return;
    }

    if (password.isEmpty) {
      showSnackBar(context, 'Password cannot be empty', error: true);
      return;
    }

    setState(() {
      loading = true;
      error = null;
    });

    try {
      final user = await firebaseService.signIn(email, password);

      if (user != null && mounted) {
        if (user.emailVerified == false) {
          await firebaseService.sendEmailVerification();
          setState(() {
            loading = true;
          });
          showSnackBar(context, 'Verify Email! Please check your inbox.');
          await firebaseService.waitForEmailVerification(user);
        }

        context.read<AuthBloc>().add(LoggedIn());
        Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
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
    final firebaseService = RepositoryProvider.of<FirebaseService>(context);

    return loading
        ? const CustomLoader(waitingText: "Loading User Data...")
        : Scaffold(
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
                      'Login to Your Account',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
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
                  suffixIcon: VisibilityIconButton(
                    obscureText: obscureText,
                    onPressed: () => setState(() => obscureText = !obscureText),
                  ),
                ),
                const SizedBox(height: 16),

                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                // Login Button
                AuthButton(
                  onPressed: () => _login(firebaseService),
                  label: loading ? 'Logging in...' : 'Login',
                ),
                const SizedBox(height: 16),

                // Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClickableTextSpanRow(
                      text: 'Forgot Password? ',
                      actionText: 'Reset',
                      onTap: () {
                        Navigator.pushNamed(context, resetPassRoute);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClickableTextSpanRow(
                      text: "Don't have an account? ",
                      actionText: 'Register',
                      onTap: () {
                        Navigator.pushReplacementNamed(context, registerRoute);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider
                buildDividerWithText('OR'),
                const SizedBox(height: 16),

                // Social Login Buttons
                SocialLoginButtons(
                  icon: Brand(Brands.google),
                  label: 'Continue with Google',
                  onPressed: () {
                    // Google login logic
                  },
                ),
                const SizedBox(height: 12),
                SocialLoginButtons(
                  icon: Icon(Icons.apple, size: 40),
                  label: 'Continue with Apple',
                  onPressed: () {
                    // Apple login logic
                  },
                ),
              ],
            ),
          ),
        );
  }
}
