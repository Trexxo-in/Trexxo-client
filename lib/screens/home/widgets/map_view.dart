import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trexxo_mobility/widgets/map_sample.dart';

class MapView extends StatelessWidget {
  final LatLng? currentPosition;
  const MapView({super.key, this.currentPosition});

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      initialCameraPosition: CameraPosition(
        target: currentPosition ?? const LatLng(37.7749, -122.4194),
        zoom: 14,
      ),
    );
  }
}
