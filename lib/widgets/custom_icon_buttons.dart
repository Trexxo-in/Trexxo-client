import 'package:flutter/material.dart';
import 'package:trexxo_mobility/utils/theme.dart';

Widget backIconButton(BuildContext context) {
  return Positioned(
    top: 40,
    left: 8,
    child: IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded),
      iconSize: 24.0,
      onPressed: () => Navigator.pop(context),
    ),
  );
}

class VisibilityIconButton extends StatelessWidget {
  final bool obscureText;
  final VoidCallback onPressed;
  const VisibilityIconButton({
    super.key,
    required this.obscureText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        iconSize: 24,
        backgroundColor: Colors.transparent,
      ),
      icon: Icon(
        obscureText
            ? Icons.visibility_off_outlined
            : Icons.remove_red_eye_outlined,
        color: primaryColor,
      ),
      onPressed: onPressed,
    );
  }
}
