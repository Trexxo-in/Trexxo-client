import 'package:equatable/equatable.dart';
import 'package:trexxo_mobility/models/waypoint_model.dart';
import 'booking_event.dart';

abstract class BookingState extends Equatable {
  const BookingState();
  @override
  List<Object?> get props => [];
}

/// Booking hasn't started yet
class BookingInitial extends BookingState {}

/// User selected pickup and/or dropoff (but not serviceType yet)
class LocationSelectedState extends BookingState {
  final WayPoint? pickup;
  final WayPoint? dropoff;

  const LocationSelectedState({this.pickup, this.dropoff});

  LocationSelectedState copyWith({WayPoint? pickup, WayPoint? dropoff}) {
    return LocationSelectedState(
      pickup: pickup ?? this.pickup,
      dropoff: dropoff ?? this.dropoff,
    );
  }

  @override
  List<Object?> get props => [pickup, dropoff];
}

/// Service type selected, but not submitted yet
class ServiceTypeSelectedState extends BookingState {
  final WayPoint? pickup;
  final WayPoint? dropoff;
  final ServiceType serviceType;

  const ServiceTypeSelectedState({
    required this.pickup,
    required this.dropoff,
    required this.serviceType,
  });

  @override
  List<Object?> get props => [pickup, dropoff, serviceType];
}

/// Full booking is submitted
class BookingDetailsSubmittedState extends BookingState {}

/// Driver search
class DriverMatchingInProgress extends BookingState {}

class DriverAssignedState extends BookingState {}

class DriverArrivedState extends BookingState {}

class RideInProgressState extends BookingState {}

class RideCompletedState extends BookingState {}

class AwaitingPaymentState extends BookingState {}

class PaymentSuccessState extends BookingState {}

class PaymentFailureState extends BookingState {
  final String reason;
  const PaymentFailureState(this.reason);
  @override
  List<Object?> get props => [reason];
}

class BookingCancelledState extends BookingState {}

class BookingErrorState extends BookingState {
  final String error;
  const BookingErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
