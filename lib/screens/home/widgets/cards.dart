import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/blocs/booking/booking_bloc.dart';
import 'package:trexxo_mobility/blocs/booking/booking_event.dart';

import 'package:flutter/material.dart';
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

    // Start booking and set fields in one event dispatch
    bookingBloc.add(BookingStarted());
    bookingBloc.add(PickupLocationSelected(pickup));
    bookingBloc.add(DropoffLocationSelected(dropoff));
    bookingBloc.add(ServiceTypeSelected(ServiceType.ride));
    bookingBloc.add(BookingSubmitted());

    showSnackBar(context, "Booking request submitted!");
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = Colors.white.withOpacity(0.95);
    const borderRadius = 12.0;
    const padding = 16.0;
    final boxShadow = BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 10,
      offset: const Offset(0, 5),
    );

    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          padding: const EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [boxShadow],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Location loader and refresh button row

              // Title
              const Text(
                'Get a Ride Now',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Pickup input
              LocationInputField(
                controller: pickupController,
                label: 'Pickup Location',
                icon: Icons.my_location,
              ),
              const SizedBox(height: 12),

              // Dropoff input
              LocationInputField(
                controller: dropoffController,
                label: 'Drop-off Location',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),

              // Confirm button
              ElevatedButton.icon(
                onPressed: () => _submitRideRequest(context),
                icon: const Icon(Icons.check),
                label: const Text('Confirm Ride'),
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
    );
  }
}
