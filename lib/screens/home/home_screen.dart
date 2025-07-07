import 'package:flutter/material.dart';

import 'package:trexxo_mobility/screens/home/widgets/cards.dart';
import 'package:trexxo_mobility/screens/home/widgets/icon_buttons.dart';
import 'package:trexxo_mobility/screens/home/widgets/map_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
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
                    RideRequestCard(
                      pickupController: _pickupController,
                      dropoffController: _dropoffController,
                    ),
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
