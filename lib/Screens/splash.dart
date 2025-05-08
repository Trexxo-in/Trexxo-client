import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trexxo_cab_client/Screens/welcome.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});
  @override
  State<Splash_Screen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash_Screen> {
  final delay = const Duration(seconds: 4);
  @override
  void initState() {
    super.initState();
    Timer(delay, () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Welcome_Screen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: "trexxo_welcome",
        child: Scaffold(
          body: Center(
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ),
    );
  }
}
