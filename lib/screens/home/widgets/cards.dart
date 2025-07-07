import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:trexxo_mobility/blocs/booking/booking_bloc.dart';
import 'package:trexxo_mobility/blocs/booking/booking_event.dart';
import 'package:trexxo_mobility/cubits/location_cubit.dart';
import 'package:trexxo_mobility/cubits/ride_request_cubit.dart';
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
    bookingBloc
      ..add(BookingStarted())
      ..add(PickupLocationSelected(pickup))
      ..add(DropoffLocationSelected(dropoff))
      ..add(ServiceTypeSelected(ServiceType.ride))
      ..add(BookingSubmitted());

    showSnackBar(context, "Booking request submitted!");
    Navigator.of(context).pop();
  }

  void _showExpandedModal(BuildContext context) {
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Set your destination',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _showExpandedModal(context),
              child: AbsorbPointer(
                child: LocationInputField(
                  controller: dropoffController,
                  label: 'Where to?',
                  icon: Icons.location_on,
                ),
              ),
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

  @override
  void initState() {
    super.initState();
    _setInitialPickup();
  }

  Future<void> _setInitialPickup() async {
    final locationCubit = context.read<LocationCubit>();
    final fallback = locationCubit.state.lastKnownLocation;

    final waypoint =
        fallback != null
            ? await MapService.getLocationInfo(fallback)
            : await MapService.getPickupWaypointFromCurrentLocation();

    if (!mounted || waypoint == null) return;

    widget.pickupController.text = waypoint.name;
    context.read<RideRequestCubit>().setPickup(waypoint);
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
    if (!mounted || waypoint == null) return;

    final controller =
        _isSearchingPickup ? widget.pickupController : widget.dropoffController;

    controller.text = waypoint.name;

    final cubit = context.read<RideRequestCubit>();
    _isSearchingPickup ? cubit.setPickup(waypoint) : cubit.setDropoff(waypoint);

    setState(() => _predictions.clear());
    FocusScope.of(context).unfocus();
  }

  Widget _buildPredictionList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _predictions.length,
      itemBuilder: (context, index) {
        final p = _predictions[index];
        return ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(p.fullText),
          subtitle: Text(p.secondaryText),
          onTap: () => _selectPrediction(p),
        );
      },
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
              SearchField(
                controller: widget.pickupController,
                label: 'Pickup Location',
                icon: const Icon(Icons.my_location),
                onChanged: (value) => _onSearchChanged(value, true),
                onClear: () {
                  widget.pickupController.clear();
                  setState(() => _predictions.clear());
                },
              ),
              const SizedBox(height: 12),
              SearchField(
                controller: widget.dropoffController,
                label: 'Destination',
                icon: const Icon(Icons.location_on),
                onChanged: (value) => _onSearchChanged(value, false),
                onClear: () {
                  widget.dropoffController.clear();
                  setState(() => _predictions.clear());
                },
              ),

              if (_predictions.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildPredictionList(),
              ],
            ],
          ),
        );
      },
    );
  }
}
