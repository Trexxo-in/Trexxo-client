import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final CameraPosition initialCameraPosition;

  const MapWidget({Key? key, required this.initialCameraPosition})
    : super(key: key);

  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> animateCamera(CameraPosition position) async {
    final controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: widget.initialCameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false, // Disabled native button to use custom
      onMapCreated: (controller) => _controller.complete(controller),
    );
  }
}
