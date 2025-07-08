import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trexxo_mobility/cubits/ride_request_cubit.dart';
import 'package:trexxo_mobility/models/waypoint_model.dart';
import 'package:trexxo_mobility/services/map_service.dart';
import 'package:trexxo_mobility/utils/constants.dart';
import 'package:trexxo_mobility/utils/location.dart';
import 'package:trexxo_mobility/utils/theme.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LatLng _initialLatLng = defaultLocation;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final currentLocation = await getLocation();
    if (!mounted || currentLocation == null) return;

    setState(() => _initialLatLng = currentLocation);
    await MapService.animateCameraTo(currentLocation, zoom: 15);
  }

  Future<void> _updateMarkersAndPolyline(
    WayPoint? pickup,
    WayPoint? dropoff,
  ) async {
    final updatedMarkers = <Marker>{};

    if (pickup != null) {
      updatedMarkers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: pickup.location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'Pickup', snippet: pickup.address),
        ),
      );
    }

    if (dropoff != null) {
      updatedMarkers.add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: dropoff.location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'Dropoff', snippet: dropoff.address),
        ),
      );
    }

    final updatedPolylines = <Polyline>{};

    if (pickup != null && dropoff != null) {
      final routePoints = await MapService.getPolylineRoute(
        pickup.location,
        dropoff.location,
      );

      if (routePoints.isNotEmpty) {
        updatedPolylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            color: primaryColor,
            width: 5,
            points: routePoints,
          ),
        );
      }
    }

    setState(() {
      _markers = updatedMarkers;
      _polylines = updatedPolylines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RideRequestCubit, RideRequestState>(
      listener: (context, state) {
        _updateMarkersAndPolyline(state.pickup, state.dropoff);
      },
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: _initialLatLng, zoom: 12),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: MapService.onMapCreated,
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
