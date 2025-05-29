import 'package:flutter/material.dart';
import 'package:trexxo_mobility/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => Navigator.pushNamed(context, profileRoute),
              ),
            ],
          ),
        ],
      ),
      body: const Center(child: Text('Welcome to Home')),
    );
  }
}
