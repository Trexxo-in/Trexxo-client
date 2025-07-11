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
    final rideCubit = context.read<RideRequestCubit>();
    final pickup = rideCubit.state.pickup;
    final dropoff = rideCubit.state.dropoff;

    if (pickup == null || dropoff == null) {
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
  // loaders
  bool _isFetchingInitialPickup = false;
  bool _isSearchingPickupField = false;
  bool _isSearchingDropoffField = false;

  final FocusNode _pickupFocusNode = FocusNode();
  final FocusNode _dropoffFocusNode = FocusNode();

  final List<AutocompletePrediction> _predictions = [];
  Timer? _debounce;
  bool _isSearchingPickup = false;

  @override
  void initState() {
    super.initState();
    final rideState = context.read<RideRequestCubit>().state;
    if (rideState.pickup == null) {
      _setInitialPickup();
    }

    _pickupFocusNode.addListener(() {
      if (_pickupFocusNode.hasFocus) {
        setState(() => _isSearchingPickup = true);
      }
    });

    _dropoffFocusNode.addListener(() {
      if (_dropoffFocusNode.hasFocus) {
        setState(() => _isSearchingPickup = false);
      }
    });
  }

  Future<void> _setInitialPickup() async {
    setState(() => _isFetchingInitialPickup = true);

    final locationCubit = context.read<LocationCubit>();
    final fallback = locationCubit.state.lastKnownLocation;

    final waypoint =
        fallback != null
            ? await MapService.getLocationInfo(fallback)
            : await MapService.getPickupWaypointFromCurrentLocation();

    if (!mounted || waypoint == null) return;

    widget.pickupController.text = waypoint.name;
    context.read<RideRequestCubit>().setPickup(waypoint);
    setState(() => _isFetchingInitialPickup = false);
  }

  void _onSearchChanged(String query, bool isPickup) {
    _debounce?.cancel();

    if (query.trim().length < 2) {
      setState(() {
        _predictions.clear();
        if (isPickup) {
          _isSearchingPickupField = false;
        } else {
          _isSearchingDropoffField = false;
        }
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      setState(() {
        if (isPickup) {
          _isSearchingPickupField = true;
        } else {
          _isSearchingDropoffField = true;
        }
      });

      final results = await MapService.searchPlacePredictions(query);
      if (!mounted) return;

      setState(() {
        _predictions
          ..clear()
          ..addAll(results);

        if (isPickup) {
          _isSearchingPickupField = false;
        } else {
          _isSearchingDropoffField = false;
        }
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

    final rideCubit = context.read<RideRequestCubit>();
    final locationCubit = context.read<LocationCubit>();

    _isSearchingPickup
        ? rideCubit.setPickup(waypoint)
        : rideCubit.setDropoff(waypoint);

    // ✅ Add selected location to history
    locationCubit.addToHistory(waypoint);

    setState(() => _predictions.clear());
    FocusScope.of(context).unfocus();
  }

  Widget _buildPredictionList() {
    final history = context.read<LocationCubit>().state.history.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (history.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Recent Locations',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                history.map((waypoint) {
                  return ActionChip(
                    label: Text(waypoint.name),
                    onPressed: () {
                      // Populate controller text manually
                      final controller =
                          _isSearchingPickup
                              ? widget.pickupController
                              : widget.dropoffController;

                      controller.text = waypoint.name;

                      final rideCubit = context.read<RideRequestCubit>();
                      _isSearchingPickup
                          ? rideCubit.setPickup(waypoint)
                          : rideCubit.setDropoff(waypoint);

                      FocusScope.of(context).unfocus();
                      setState(() => _predictions.clear());
                    },
                  );
                }).toList(),
          ),
          const Divider(height: 24),
        ],
        ListView.builder(
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
        ),
      ],
    );
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
                focusNode: _pickupFocusNode,
                label: 'Pickup Location',
                icon: const Icon(Icons.my_location),
                onChanged: (value) => _onSearchChanged(value, true),
                onClear: () {
                  widget.pickupController.clear();
                  context.read<RideRequestCubit>().clearPickup();
                  setState(() => _predictions.clear());
                },
                isLoading: _isFetchingInitialPickup || _isSearchingPickupField,
              ),

              const SizedBox(height: 12),

              SearchField(
                controller: widget.dropoffController,
                focusNode: _dropoffFocusNode,
                label: 'Destination',
                icon: const Icon(Icons.location_on),
                onChanged: (value) => _onSearchChanged(value, false),
                onClear: () {
                  widget.dropoffController.clear();
                  context.read<RideRequestCubit>().clearDropoff();
                  setState(() => _predictions.clear());
                },
                isLoading: _isSearchingDropoffField,
              ),

              // if (_predictions.isNotEmpty) ...[
              const SizedBox(height: 12),
              _buildPredictionList(),
              // ],
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _pickupFocusNode.dispose();
    _dropoffFocusNode.dispose();
    super.dispose();
  }
}
