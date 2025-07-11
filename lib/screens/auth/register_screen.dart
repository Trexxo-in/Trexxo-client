import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/services/firebase_service.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/widgets/custom_dividers.dart';
import 'package:trexxo_mobility/widgets/custom_icon_buttons.dart';
import 'package:trexxo_mobility/widgets/custom_snackbar.dart';
import 'package:trexxo_mobility/widgets/custom_text_buttons.dart';
import 'package:trexxo_mobility/widgets/custom_text_fields.dart';
import 'package:trexxo_mobility/widgets/custom_laoder.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool loading = false;
  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _register(FirebaseService firebaseService) async {
    setState(() => loading = true);

    try {
      final user = await firebaseService.register(
        _emailController.text.trim(),
        _passController.text,
      );

      if (user != null) {
        await firebaseService.sendEmailVerification();
        final verified = await firebaseService.waitForEmailVerification(user);

        final ref = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);

        await ref.set({
          'uid': user.uid,
          'email': user.email,
          'emailVerified': user.emailVerified,
          'createdAt': FieldValue.serverTimestamp(),
        });

        if (verified && mounted) {
          await ref.update({'emailVerified': user.emailVerified});

          context.read<AuthBloc>().add(LoggedIn());
          Navigator.pushReplacementNamed(context, profileSetupRoute);
          showSnackBar(context, 'Email verified successfully!');
        }
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, e.toString(), error: true);
      }
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseService = RepositoryProvider.of<FirebaseService>(context);

    return loading
        ? const CustomLoader(
          waitingText: "Waiting for user to \nverify email id",
        )
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
                      'Register Your Account',
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

                // Register Button
                AuthButton(
                  onPressed: () => _register(firebaseService),
                  label: loading ? 'Registering...' : 'Register',
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClickableTextSpanRow(
                      text: 'Already have an account? ',
                      actionText: 'Login',
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                buildDividerWithText('OR'),
                const SizedBox(height: 16),

                SocialLoginButtons(
                  icon: Brand(Brands.google),
                  label: 'Continue with Google',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, profileSetupRoute);
                  },
                ),
                const SizedBox(height: 12),

                SocialLoginButtons(
                  icon: Icon(Icons.apple, size: 40),
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
