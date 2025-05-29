import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trexxo_mobility/utils/theme.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String label;

  const SocialLoginButtons({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 340,
        height: 60,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(width: 38, height: 38, child: icon),
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const Opacity(
                // Invisible spacer to balance layout
                opacity: 0,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(Icons.abc), // same size as icon to keep symmetry
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Widget? icon;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 60,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            if (icon != null) ...[const SizedBox(width: 8), icon!],
          ],
        ),
      ),
    );
  }
}

class ClickableTextSpanRow extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final TextStyle? actionStyle;
  final TextAlign textAlign;

  const ClickableTextSpanRow({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
    this.textStyle,
    this.actionStyle,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: textStyle ?? theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
        children: [
          TextSpan(text: text),
          TextSpan(
            text: actionText,
            style:
                actionStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
