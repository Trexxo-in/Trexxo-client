import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trexxo_mobility/screens/home/widgets/cards.dart';
import 'package:trexxo_mobility/screens/home/widgets/icon_buttons.dart';
import 'package:trexxo_mobility/screens/home/widgets/map_view.dart';
import 'package:trexxo_mobility/utils/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng? _currentPosition;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _loadInitialLocation();
  }

  Future<void> _loadInitialLocation() async {
    setState(() => _isLoadingLocation = true);

    final location = await getLocation();
    if (location == null) {
      _showSnackBar('Failed to get location or permission denied');
    }
    if (!mounted) return;

    setState(() {
      _currentPosition = location;
      _isLoadingLocation = false;
    });
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            MapView(currentPosition: _currentPosition),
            const PositionedProfileButton(),
            PositionedRideRequestCard(
              isLoading: _isLoadingLocation,
              onGetLocationPressed: _loadInitialLocation,
            ),
          ],
        ),
      ),
    );
  }
}
