import 'package:flutter/material.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/widgets/custom_text_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 70),
                Image.asset("assets/images/logo_name_column.png", width: 250),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Your Journey, ',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: textTheme.bodySmall?.color,
                        ),
                      ),
                      Text(
                        'Your Rules',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5555FF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Book rides effortlessly, customize your trip, and experience seamless travel with complete control at your fingertips.",
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            AuthButton(
              onPressed:
                  () => Navigator.pushReplacementNamed(context, onBoardRoute),
              label: 'Get Started',
            ),
          ],
        ),
      ),
    );
  }
}
