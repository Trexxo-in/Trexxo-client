import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/cubits/onboarding_cubit.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/utils/theme.dart';
import 'package:trexxo_mobility/widgets/custom_text_buttons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int currentIndex = 0;
  final int totalPages = 3;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final newIndex = _controller.page?.round() ?? 0;
      if (newIndex != currentIndex) {
        setState(() => currentIndex = newIndex);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingPages = [
      const OnboardingPage(
        imagePath: "assets/images/car.png",
        title: "Book a Ride",
        description:
            "Choose your pickup, set your stops, and book a ride in seconds — simple, fast, and flexible.",
      ),
      const OnboardingPage(
        imagePath: "assets/images/track.png",
        title: "Track your ride",
        description:
            "Stay updated with real-time tracking, live driver location, and accurate arrival times for a worry-free experience.",
      ),
      const OnboardingPage(
        imagePath: "assets/images/safe.png",
        title: "Safe & comfortable",
        description:
            "Every journey is backed by trusted drivers, well-maintained vehicles, and a commitment to your safety and comfort.",
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                children: onboardingPages,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(totalPages, (index) {
                  final isActive = index == currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 30 : 20,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor : Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                }),
              ),
            ),
            if (currentIndex != 2)
            AuthButton(
              onPressed: () {
                       _controller.animateToPage(++currentIndex,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                      },
              label: "Next",
              icon:Icon(Icons.arrow_forward),
            )
                else
            AuthButton(
              onPressed: () {
                context.read<OnboardingCubit>().completeOnboarding();
                Navigator.pushReplacementNamed(context, authRoute);
              },
              label: "Get Started",
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 70),
          Center(
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 100,
              child: Padding(
                padding: const EdgeInsets.all(33),
                child: Image.asset(imagePath, height: 165, width: 165),
              ),
            ),
          ),
          const SizedBox(height: 80),
          Text(
            title,
            style: textTheme.displayLarge?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              description,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
