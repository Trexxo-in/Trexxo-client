import 'package:equatable/equatable.dart';
import 'package:trexxo_mobility/models/waypoint_model.dart';

/// Enum for selecting type of service
enum ServiceType { ride, ambulance, movers }

/// Base class for all booking events
abstract class BookingEvent extends Equatable {
  const BookingEvent();
  @override
  List<Object?> get props => [];
}

/// Booking flow started
class BookingStarted extends BookingEvent {}

/// Pickup location selected
class PickupLocationSelected extends BookingEvent {
  final WayPoint pickupLocation;
  const PickupLocationSelected(this.pickupLocation);
  @override
  List<Object?> get props => [pickupLocation];
}

/// Dropoff location selected
class DropoffLocationSelected extends BookingEvent {
  final WayPoint dropoffLocation;
  const DropoffLocationSelected(this.dropoffLocation);
  @override
  List<Object?> get props => [dropoffLocation];
}

/// Service type selected (ride / ambulance / movers)
class BookingServiceTypeSelected extends BookingEvent {
  final ServiceType serviceType;
  const BookingServiceTypeSelected(this.serviceType);
  @override
  List<Object?> get props => [serviceType];
}

/// User submitted the full booking
class BookingDetailsSubmitted extends BookingEvent {}

/// Driver matching
class DriverMatchingStarted extends BookingEvent {}

class DriverAssigned extends BookingEvent {}

class DriverArrivedAtPickup extends BookingEvent {}

class RideStarted extends BookingEvent {}

class RideCompleted extends BookingEvent {}

class AwaitingPayment extends BookingEvent {}

class PaymentSuccess extends BookingEvent {}

class PaymentFailure extends BookingEvent {
  final String reason;
  const PaymentFailure(this.reason);
  @override
  List<Object?> get props => [reason];
}

class BookingCancelled extends BookingEvent {}

class TripRated extends BookingEvent {
  final int rating;
  final String? feedback;
  const TripRated(this.rating, {this.feedback});
  @override
  List<Object?> get props => [rating, feedback];
}
