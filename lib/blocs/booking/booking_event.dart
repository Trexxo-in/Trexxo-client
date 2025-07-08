import 'package:equatable/equatable.dart';
import 'package:trexxo_mobility/models/waypoint_model.dart';

enum ServiceType { ride, ambulance, movers }

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class BookingStarted extends BookingEvent {}

class PickupLocationSelected extends BookingEvent {
  final WayPoint pickupLocation;

  const PickupLocationSelected(this.pickupLocation);

  @override
  List<Object?> get props => [pickupLocation];
}

class DropoffLocationSelected extends BookingEvent {
  final WayPoint dropoffLocation;

  const DropoffLocationSelected(this.dropoffLocation);

  @override
  List<Object?> get props => [dropoffLocation];
}

class ServiceTypeSelected extends BookingEvent {
  final ServiceType serviceType;

  const ServiceTypeSelected(this.serviceType);

  @override
  List<Object?> get props => [serviceType];
}

class BookingSubmitted extends BookingEvent {}
