import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/utils/location.dart';
import 'package:trexxo_mobility/widgets/custom_snackbar.dart';

class PositionedProfileButton extends StatelessWidget {
  const PositionedProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      child: IconButton(
        icon: const Icon(Icons.person, size: 28),
        tooltip: 'Profile',
        onPressed: () => Navigator.pushNamed(context, profileRoute),
      ),
    );
  }
}

class MyLocationButton extends StatelessWidget {
  final Completer<GoogleMapController> mapController;
  const MyLocationButton({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () async {
            final latlong = await getLocation();
            if (latlong == null) {
              showSnackBar(context, "Unable to get current location");
              return;
            }
            log("Current location: ${latlong.latitude}, ${latlong.longitude}");
            animateCamera(
              CameraPosition(target: latlong, zoom: 15),
              mapController,
            );
          },

          icon: const Icon(Icons.my_location_rounded, size: 32),
          tooltip: 'Get Current Location',
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
