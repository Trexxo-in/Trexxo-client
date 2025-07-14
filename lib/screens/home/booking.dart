import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/blocs/booking/booking_bloc.dart';
import 'package:trexxo_mobility/blocs/booking/booking_state.dart';
import 'package:trexxo_mobility/screens/home/widgets/init_card.dart';
import 'package:trexxo_mobility/screens/home/widgets/ride_confirmation_card.dart';

class BookingStateHandler extends StatelessWidget {
  const BookingStateHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        log('Current Booking State: $state', name: 'BookingStateHandler');
        if (state is BookingInitial) {
          return const InitCard();
        }

        if (state is LocationSelectedState) {
          return RideConfirmationBottomSheet();
        }

        if (state is ServiceTypeSelectedState) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Pickup: ${state.pickup?.address}"),
                Text("Dropoff: ${state.dropoff?.address}"),
                Text("Service Type: ${state.serviceType.name}"),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
              ],
            ),
          );
        }

        if (state is BookingDetailsSubmittedState) {
          return const Center(child: Text("Booking Submitted Successfully"));
        }

        if (state is DriverMatchingInProgress) {
          return const Center(child: Text("Searching for a driver..."));
        }

        if (state is DriverAssignedState) {
          return const Center(child: Text("Driver matched!"));
        }

        if (state is DriverArrivedState) {
          return const Center(
            child: Text("Driver has arrived at pickup location"),
          );
        }

        if (state is RideInProgressState) {
          return const Center(child: Text("Ride in progress..."));
        }

        if (state is RideCompletedState) {
          return const Center(child: Text("Ride completed!"));
        }

        if (state is AwaitingPaymentState) {
          return const Center(child: Text("Awaiting payment"));
        }

        if (state is PaymentSuccessState) {
          return const Center(child: Text("Payment completed successfully"));
        }

        if (state is PaymentFailureState) {
          return Center(child: Text("Payment failed: ${state.reason}"));
        }

        if (state is BookingCancelledState) {
          return const Center(child: Text("Booking cancelled"));
        }

        if (state is BookingErrorState) {
          return Center(child: Text("Error: ${state.error}"));
        }

        return const Center(child: Text("Unknown booking state"));
      },
    );
  }
}
