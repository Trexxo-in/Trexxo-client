import 'package:equatable/equatable.dart';

enum ServiceType { ride, ambulance, movers }

enum RideType { ride, ambulance, movers, delivery }

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class BookingStarted extends BookingEvent {}

class PickupLocationSelected extends BookingEvent {
  final String pickupLocation;

  const PickupLocationSelected(this.pickupLocation);

  @override
  List<Object?> get props => [pickupLocation];
}

class DropoffLocationSelected extends BookingEvent {
  final String dropoffLocation;

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
