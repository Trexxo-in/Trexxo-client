import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    hide LatLng;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:trexxo_mobility/models/waypoint_model.dart';
import 'package:trexxo_mobility/utils/location.dart';

const String kGoogleApiKey = 'AIzaSyCqZcsV73WmLS0kyshddbbO0yo4XhLZNmA';

class MapService {
  static final Completer<GoogleMapController> _controller = Completer();
  static final FlutterGooglePlacesSdk _places = FlutterGooglePlacesSdk(
    kGoogleApiKey,
  );

  static const LatLng defaultLatLng = LatLng(37.7749, -122.4194);

  static CameraPosition get initialCameraPosition =>
      const CameraPosition(target: defaultLatLng, zoom: 12);

  static void onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  static Future<void> animateCameraTo(LatLng target, {double zoom = 14}) async {
    try {
      final controller = await _controller.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: target, zoom: zoom),
        ),
      );
    } catch (e) {
      dev.log("❌ Error animating camera: $e");
    }
  }

  static Future<void> animateToCurrentLocation() async {
    final current = await getLocation();
    if (current != null) {
      await animateCameraTo(current, zoom: 15);
    } else {
      dev.log("❗ Failed to fetch current location.");
    }
  }

  static Future<WayPoint?> getPickupWaypointFromCurrentLocation() async {
    try {
      final currentLatLng = await getLocation();
      if (currentLatLng == null) {
        dev.log("❗ Could not retrieve current location.");
        return null;
      }
      return await getLocationInfo(currentLatLng);
    } catch (e, stackTrace) {
      dev.log(
        "❗ Exception in getPickupWaypointFromCurrentLocation: $e",
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  static Future<WayPoint?> getLocationInfo(LatLng latLng) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json'
        '?latlng=${latLng.latitude},${latLng.longitude}&key=$kGoogleApiKey',
      );

      final response = await http.get(url);
      if (response.statusCode != 200) {
        dev.log("❗ Geocoding API failed: ${response.statusCode}");
        return null;
      }

      final data = json.decode(response.body);
      if (data['status'] != 'OK' || data['results'].isEmpty) {
        dev.log("⚠️ Geocoding error: ${data['status']}");
        return null;
      }

      final result = data['results'][0];
      final address = result['formatted_address'] ?? 'Unknown Address';

      String name = 'Unnamed Location';
      final components = result['address_components'] as List?;
      if (components != null && components.isNotEmpty) {
        name = components.first['long_name'] ?? name;
      }

      return WayPoint(name: name, address: address, location: latLng);
    } catch (e, stackTrace) {
      dev.log("❗ Exception in getLocationInfo: $e", stackTrace: stackTrace);
      return null;
    }
  }

  static Future<List<AutocompletePrediction>> searchPlacePredictions(
    String query,
  ) async {
    if (query.trim().isEmpty) return [];

    final result = await _places.findAutocompletePredictions(
      query,
      countries: ['IN'],
    );
    return result.predictions;
  }

  static Future<WayPoint?> fetchPlaceDetailsFromPrediction(
    AutocompletePrediction prediction,
  ) async {
    try {
      final res = await _places.fetchPlace(
        prediction.placeId,
        fields: [PlaceField.Name, PlaceField.Address, PlaceField.Location],
      );

      final place = res.place;
      if (place != null && place.latLng != null) {
        return WayPoint(
          name: place.name ?? '',
          address: place.address ?? '',
          location: LatLng(place.latLng!.lat, place.latLng!.lng),
        );
      }
    } catch (e) {
      dev.log("❗ Error fetching place details: $e");
    }
    return null;
  }

  /// ✅ Fetch navigated polyline using Google Directions API
  static Future<List<LatLng>> getPolylineRoute(
    LatLng origin,
    LatLng destination,
  ) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&mode=driving'
        '&key=$kGoogleApiKey',
      );

      final response = await http.get(url);
      if (response.statusCode != 200) {
        dev.log("❌ Directions API failed: ${response.statusCode}");
        return [];
      }

      final data = json.decode(response.body);
      if (data['status'] != 'OK' || data['routes'].isEmpty) {
        dev.log("⚠️ No routes found. Status: ${data['status']}");
        return [];
      }

      final encoded = data['routes'][0]['overview_polyline']['points'];
      return _decodePolyline(encoded);
    } catch (e, stackTrace) {
      dev.log("❗ Exception in getPolylineRoute: $e", stackTrace: stackTrace);
      return [];
    }
  }

  /// ✅ Decode encoded polyline
  static List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0, b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return points;
  }
}
