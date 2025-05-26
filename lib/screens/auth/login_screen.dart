import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '', password = '';
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
            loading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator:
                            (val) =>
                                val != null && val.contains('@')
                                    ? null
                                    : 'Enter valid email',
                        onChanged: (val) => email = val,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        validator:
                            (val) =>
                                val != null && val.length >= 6
                                    ? null
                                    : '6+ chars required',
                        onChanged: (val) => password = val,
                      ),
                      const SizedBox(height: 20),
                      if (error != null)
                        Text(error!, style: const TextStyle(color: Colors.red)),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                              error = null;
                            });

                            try {
                              final user = await authService.signIn(
                                email: email,
                                password: password,
                              );
                              if (user != null) {
                                context.read<AuthBloc>().add(LoggedIn());
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              setState(() {
                                error = e.toString();
                                loading = false;
                              });
                            }
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
