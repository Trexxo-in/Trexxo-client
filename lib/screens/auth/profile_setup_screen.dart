import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trexxo_mobility/blocs/auth/auth_bloc.dart';
import 'package:trexxo_mobility/blocs/auth/auth_event.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/widgets/custom_snackbar.dart';

import 'package:trexxo_mobility/widgets/custom_text_buttons.dart';
import 'package:trexxo_mobility/widgets/custom_text_fields.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _mobileController = TextEditingController();
  bool _agreedToTnC = false;
  User? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _emailController.text = user?.email ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _selectDOB(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      _dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

  void _submitProfile() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _mobileController.text.isEmpty ||
        !_agreedToTnC) {
      showSnackBar(
        context,
        'Please complete all fields and accept terms.',
        error: true,
      );

      return;
    }

    final ref = FirebaseFirestore.instance.collection('users').doc(user!.uid);
    await ref.update({
      'name': _nameController.text.trim(),
      'dob': _dobController.text.trim(),
      'mobile': _mobileController.text.trim(),
      'agreedToTnC': _agreedToTnC,
    });

    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);

    showSnackBar(context, 'Profile setup completed!');
  }

  @override
  Widget build(BuildContext context) {
    const fieldPadding = EdgeInsets.symmetric(vertical: 8.0);

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Setup Your Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: fieldPadding,
                      child: CustomTextField(
                        label: 'Full Name',
                        hintText: 'Enter your full name',
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: fieldPadding,
                      child: CustomTextField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: fieldPadding,
                      child: GestureDetector(
                        onTap: () => _selectDOB(context),
                        child: AbsorbPointer(
                          child: CustomTextField(
                            label: 'Date of Birth',
                            hintText: 'Select your DOB',
                            controller: _dobController,
                            prefixIcon: Icons.calendar_today,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: fieldPadding,
                      child: CustomTextField(
                        label: 'Mobile Number',
                        hintText: 'Enter your phone number',
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('I agree to the Terms & Conditions'),
                      value: _agreedToTnC,
                      onChanged:
                          (value) =>
                              setState(() => _agreedToTnC = value ?? false),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(height: 20),
                    AuthButton(onPressed: _submitProfile, label: 'Submit'),
                  ],
                ),
              ),
            ),
          ),

          // // back button
          // backIconButton(context),
        ],
      ),
    );
  }
}
