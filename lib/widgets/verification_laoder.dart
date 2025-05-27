import 'package:flutter/material.dart';
import 'dart:math';

import 'package:trexxo_mobility/utils/theme.dart';

class VerificationLoader extends StatefulWidget {
  const VerificationLoader({Key? key}) : super(key: key);

  @override
  State<VerificationLoader> createState() => _VerificationLoaderState();
}

class _VerificationLoaderState extends State<VerificationLoader>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.deepOrangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main animation area
            SizedBox(
              width: 240,
              height: 240,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Pulsing center dot with shadow
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.4),
                            blurRadius: 30,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Rotating arc
                  AnimatedBuilder(
                    animation: _rotationController,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _rotationController.value * 2 * pi,
                        child: child,
                      );
                    },
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child: CustomPaint(painter: ArcPainter(strokeWidth: 30)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Text
            const Text(
              "Waiting for user to \nverify email id",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double strokeWidth;

  ArcPainter({required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = primaryColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..isAntiAlias = true;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = 0.0;
    final sweepAngle = pi / 2;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
