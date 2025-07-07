import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:trexxo_mobility/blocs/booking/booking_bloc.dart';
import 'package:trexxo_mobility/blocs/booking/booking_event.dart';
import 'package:trexxo_mobility/models/waypoint_model.dart';
import 'package:trexxo_mobility/services/map_service.dart';
import 'package:trexxo_mobility/widgets/custom_snackbar.dart';
import 'package:trexxo_mobility/widgets/custom_text_fields.dart';

class RideRequestCard extends StatelessWidget {
  final TextEditingController pickupController;
  final TextEditingController dropoffController;

  const RideRequestCard({
    super.key,
    required this.pickupController,
    required this.dropoffController,
  });

  void _submitRideRequest(BuildContext context) {
    final pickup = pickupController.text.trim();
    final dropoff = dropoffController.text.trim();

    if (pickup.isEmpty || dropoff.isEmpty) {
      showSnackBar(context, "Please enter both pickup and drop-off locations");
      return;
    }

    final bookingBloc = context.read<BookingBloc>();
    bookingBloc.add(BookingStarted());
    bookingBloc.add(PickupLocationSelected(pickup));
    bookingBloc.add(DropoffLocationSelected(dropoff));
    bookingBloc.add(ServiceTypeSelected(ServiceType.ride));
    bookingBloc.add(BookingSubmitted());

    showSnackBar(context, "Booking request submitted!");
    Navigator.of(context).pop();
  }

  void _showExpandedModal(BuildContext context) {
    final pickupController = TextEditingController();
    final dropoffController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (_) => RideRequestBottomSheet(
            pickupController: pickupController,

            dropoffController: dropoffController,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = Colors.white.withOpacity(0.95);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () => _showExpandedModal(context),
          child: AbsorbPointer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Set your destination',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                LocationInputField(
                  controller: dropoffController,
                  label: 'Where to?',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => _submitRideRequest(context),
                  icon: const Icon(Icons.check),
                  label: const Text('Confirm Destination'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RideRequestBottomSheet extends StatefulWidget {
  final TextEditingController pickupController;
  final TextEditingController dropoffController;

  const RideRequestBottomSheet({
    super.key,
    required this.pickupController,
    required this.dropoffController,
  });

  @override
  State<RideRequestBottomSheet> createState() => _RideRequestBottomSheetState();
}

class _RideRequestBottomSheetState extends State<RideRequestBottomSheet> {
  final List<AutocompletePrediction> _predictions = [];
  Timer? _debounce;
  bool _isSearchingPickup = false;

  WayPoint? _pickup;
  WayPoint? _destination;

  @override
  void initState() {
    super.initState();
    _initPickup();
  }

  Future<void> _initPickup() async {
    final pickup = await MapService.getPickupWaypointFromCurrentLocation();
    if (!mounted || pickup == null) return;
    setState(() {
      _pickup = pickup;
      widget.pickupController.text = pickup.name;
    });
  }

  void _onSearchChanged(String query, bool isPickup) {
    _isSearchingPickup = isPickup;

    _debounce?.cancel();
    if (query.trim().length < 2) return;

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      final results = await MapService.searchPlacePredictions(query);
      if (!mounted) return;

      setState(() {
        _predictions
          ..clear()
          ..addAll(results);
      });
    });
  }

  Future<void> _selectPrediction(AutocompletePrediction prediction) async {
    final waypoint = await MapService.fetchPlaceDetailsFromPrediction(
      prediction,
    );
    if (waypoint == null || !mounted) return;

    setState(() {
      if (_isSearchingPickup) {
        _pickup = waypoint;
        widget.pickupController.text = waypoint.name;
      } else {
        _destination = waypoint;
        widget.dropoffController.text = waypoint.name;
      }
      _predictions.clear();
    });

    FocusScope.of(context).unfocus();

    debugPrint(
      '${_isSearchingPickup ? "Pickup" : "Drop-off"}: ${waypoint.location.latitude}, ${waypoint.location.longitude}',
    );
  }

  void _clearSearch(TextEditingController controller) {
    controller.clear();
    setState(() => _predictions.clear());
  }

  Widget _buildSearchField({
    required TextEditingController controller,
    required String label,
    required bool isPickup,
    required Icon prefixIcon,
  }) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(16),
          suffixIcon:
              controller.text.isNotEmpty
                  ? SizedBox(
                    width: 32,
                    height: 32,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => _clearSearch(controller),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        splashRadius: 18,
                      ),
                    ),
                  )
                  : null,
        ),
        onChanged: (value) => _onSearchChanged(value, isPickup),
        onTap: () => _onSearchChanged(controller.text, isPickup),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 1.0,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              const Text(
                'Get a Ride Now',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildSearchField(
                controller: widget.pickupController,
                label: 'Pickup Location',
                prefixIcon: const Icon(Icons.my_location),
                isPickup: true,
              ),
              const SizedBox(height: 12),
              _buildSearchField(
                controller: widget.dropoffController,
                label: 'Destination',
                prefixIcon: const Icon(Icons.location_on),
                isPickup: false,
              ),
              if (_predictions.isNotEmpty) ...[
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _predictions.length,
                  itemBuilder: (context, index) {
                    final p = _predictions[index];
                    return ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(p.fullText ?? ''),
                      subtitle: Text(p.secondaryText ?? ''),
                      onTap: () => _selectPrediction(p),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
