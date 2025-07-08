import 'package:google_maps_flutter/google_maps_flutter.dart';

class WayPoint {
  final String name;
  final String address;
  final LatLng location;

  WayPoint({required this.name, required this.address, required this.location});

  factory WayPoint.empty() =>
      WayPoint(name: '', address: '', location: const LatLng(0.0, 0.0));

  @override
  String toString() {
    return '$name, $address (${location.latitude}, ${location.longitude})';
  }
}
