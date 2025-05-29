import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.prefixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isLight =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    final borderColor = isLight ? Colors.black38 : Colors.white38;
    final focusedBorderColor = isLight ? Colors.black54 : Colors.white54;
    final backgroundColor =
        isLight ? const Color(0xFFD9D9D9) : const Color(0x3DD9D9D9);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          autocorrect: true,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: borderColor),
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            prefixIcon:
                prefixIcon != null
                    ? Icon(prefixIcon, color: borderColor)
                    : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: backgroundColor,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}

/// Reusable input field widget.
class LocationInputField extends StatelessWidget {
  final String label;
  final IconData icon;

  const LocationInputField({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
