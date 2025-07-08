import 'package:equatable/equatable.dart';
import 'package:trexxo_mobility/models/waypoint_model.dart';
import 'booking_event.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object?> get props => [];
}

class BookingInitial extends BookingState {}

class BookingInProgress extends BookingState {
  final WayPoint? pickupLocation;
  final WayPoint? dropoffLocation;
  final ServiceType? serviceType;

  const BookingInProgress({
    this.pickupLocation,
    this.dropoffLocation,
    this.serviceType,
  });

  BookingInProgress copyWith({
    WayPoint? pickupLocation,
    WayPoint? dropoffLocation,
    ServiceType? serviceType,
  }) {
    return BookingInProgress(
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      serviceType: serviceType ?? this.serviceType,
    );
  }

  @override
  List<Object?> get props => [pickupLocation, dropoffLocation, serviceType];
}

class BookingSuccess extends BookingState {}

class BookingFailure extends BookingState {
  final String error;

  const BookingFailure(this.error);

  @override
  List<Object?> get props => [error];
}
