import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trexxo_mobility/blocs/booking/booking_bloc.dart';
import 'package:trexxo_mobility/screens/home/widgets/cards.dart';
import 'package:trexxo_mobility/screens/home/widgets/icon_buttons.dart';
import 'package:trexxo_mobility/screens/home/widgets/map_view.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/utils/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng location = defaultLocation;
  final Completer<GoogleMapController> mapController = Completer();

  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final currentLocation = await getLocation();
    if (mounted) {
      setState(() {
        location = currentLocation!;
      });
      if (currentLocation != null) {
        animateCamera(
          CameraPosition(target: currentLocation, zoom: 15),
          mapController,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingBloc(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              // gmap view
              MapView(location: location, mapController: mapController),
              // cards
              const PositionedProfileButton(),
              RideRequestCard(
                pickupController: _pickupController,
                dropoffController: _dropoffController,
              ),
              // my lcoation
              MyLocationButton(mapController: mapController),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }
}
