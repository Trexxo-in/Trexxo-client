import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LatLng?> getLocation() async {
  // Request location permission
  final permissionStatus = await Permission.location.request();
  if (!permissionStatus.isGranted) {
    // Permission denied
    return null;
  }

  try {
    // Get current position with high accuracy and a distance filter of 10 meters
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );

    // Return as LatLng
    return LatLng(position.latitude, position.longitude);
  } catch (e) {
    // Handle or log error here if needed
    return null;
  }
}
