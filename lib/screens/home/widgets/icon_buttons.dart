import 'package:flutter/material.dart';
import 'package:trexxo_mobility/utils/constants.dart';

class PositionedProfileButton extends StatelessWidget {
  const PositionedProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: IconButton(
        icon: const Icon(Icons.person, size: 28),
        tooltip: 'Profile',
        onPressed: () => Navigator.pushNamed(context, profileRoute),
      ),
    );
  }
}
