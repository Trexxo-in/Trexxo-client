import 'dart:math';
import 'package:flutter/material.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fillController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );

  late final Animation<double> _fillAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _fillController, curve: Curves.easeInOut));

  late final AnimationController _flipController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  late final Animation<double> _flipAnimation = Tween<double>(
    begin: 0.0,
    end: pi,
  ).animate(CurvedAnimation(parent: _flipController, curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();
    _fillController.forward();
    _flipController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fillController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  Widget _buildFillBackground() {
    return AnimatedBuilder(
      animation: _fillAnimation,
      builder:
          (_, __) => Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: _fillAnimation.value,
              widthFactor: 1,
              child: Container(color: primaryColor),
            ),
          ),
    );
  }

  Widget _buildFlipCircle() {
    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (_, __) {
        final isFront = _flipAnimation.value < pi / 2;
        final image =
            isFront
                ? Image.asset(appLogo, width: 200)
                : Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Image.asset(appName, width: 200),
                );

        return Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_flipAnimation.value),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child:
                isFront
                    ? image
                    : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: image,
                    ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_buildFillBackground(), Center(child: _buildFlipCircle())],
      ),
    );
  }
}
