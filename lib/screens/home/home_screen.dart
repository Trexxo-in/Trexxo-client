import 'package:flutter/material.dart';

import 'package:trexxo_mobility/screens/home/cards.dart';
import 'package:trexxo_mobility/screens/home/widgets/icon_buttons.dart';
import 'package:trexxo_mobility/screens/home/map_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const MapView(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PositionedProfileButton(),
                Column(
                  children: [
                    // MyLocationButton(),
                    RideRequestCard(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
