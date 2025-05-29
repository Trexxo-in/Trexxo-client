import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  final LatLng location;
  final Completer<GoogleMapController> mapController;

  const MapView({
    super.key,
    required this.location,
    required this.mapController,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: location, zoom: 12),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: (controller) => mapController.complete(controller),
    );
  }
}
