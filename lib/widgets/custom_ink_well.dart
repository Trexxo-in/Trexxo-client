import 'package:flutter/material.dart';

InkWell customInkWell({
  required VoidCallback onTap,
  required Widget child,
  Color? splashColor,
  Color? highlightColor,
  double? borderRadius,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
    splashColor:
        splashColor ?? Colors.deepOrangeAccent.shade100.withOpacity(0.2),
    highlightColor:
        highlightColor ?? Colors.deepOrangeAccent.shade100.withOpacity(0.2),
    child: child,
  );
}
