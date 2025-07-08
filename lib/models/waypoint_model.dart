import 'package:google_maps_flutter/google_maps_flutter.dart';

class WayPoint {
  final String name;
  final String address;
  final LatLng location;

  WayPoint({required this.name, required this.address, required this.location});

  factory WayPoint.empty() =>
      WayPoint(name: '', address: '', location: const LatLng(0.0, 0.0));

  WayPoint copyWith({String? name, String? address, LatLng? location}) {
    return WayPoint(
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'location': {
      'latitude': location.latitude,
      'longitude': location.longitude,
    },
  };

  factory WayPoint.fromJson(Map<String, dynamic> json) {
    final loc = json['location'];
    return WayPoint(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      location: LatLng(
        (loc['latitude'] ?? 0.0).toDouble(),
        (loc['longitude'] ?? 0.0).toDouble(),
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WayPoint &&
          name == other.name &&
          address == other.address &&
          location.latitude == other.location.latitude &&
          location.longitude == other.location.longitude;

  @override
  int get hashCode =>
      name.hashCode ^
      address.hashCode ^
      location.latitude.hashCode ^
      location.longitude.hashCode;

  @override
  String toString() {
    return '$name, $address (${location.latitude}, ${location.longitude})';
  }
}
