import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trexxo_mobility/services/map_service.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/utils/location.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng _location = defaultLocation;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final currentLocation = await getLocation();
    if (mounted && currentLocation != null) {
      setState(() {
        _location = currentLocation;
      });
      await MapService.animateCameraTo(currentLocation, zoom: 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(target: _location, zoom: 12),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: MapService.onMapCreated,
    );
  }
}
