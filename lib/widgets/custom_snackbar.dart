import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {bool error = false}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: error ? Colors.red : Colors.green,
    duration: const Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
