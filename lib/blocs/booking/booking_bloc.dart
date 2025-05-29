import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<BookingStarted>(_onStarted);
    on<PickupLocationSelected>(_onPickupSelected);
    on<DropoffLocationSelected>(_onDropoffSelected);
    on<ServiceTypeSelected>(_onServiceTypeSelected);
    on<BookingSubmitted>(_onSubmitted);
  }

  void _onStarted(BookingStarted event, Emitter<BookingState> emit) {
    emit(BookingInProgress());
  }

  void _onPickupSelected(
    PickupLocationSelected event,
    Emitter<BookingState> emit,
  ) {
    if (state is BookingInProgress) {
      final currentState = state as BookingInProgress;
      emit(currentState.copyWith(pickupLocation: event.pickupLocation));
    }
  }

  void _onDropoffSelected(
    DropoffLocationSelected event,
    Emitter<BookingState> emit,
  ) {
    if (state is BookingInProgress) {
      final currentState = state as BookingInProgress;
      emit(currentState.copyWith(dropoffLocation: event.dropoffLocation));
    }
  }

  void _onServiceTypeSelected(
    ServiceTypeSelected event,
    Emitter<BookingState> emit,
  ) {
    if (state is BookingInProgress) {
      final currentState = state as BookingInProgress;
      emit(currentState.copyWith(serviceType: event.serviceType));
    }
  }

  void _onSubmitted(BookingSubmitted event, Emitter<BookingState> emit) {
    if (state is BookingInProgress) {
      final current = state as BookingInProgress;
      log("Submitting booking with state: $current");
      if (current.pickupLocation != null &&
          current.dropoffLocation != null &&
          current.serviceType != null) {
        log(
          "Booking submitted with: "
          "Pickup: ${current.pickupLocation}, "
          "Dropoff: ${current.dropoffLocation}, "
          "Service: ${current.serviceType}",
          name: "Booking",
        );
        emit(BookingSuccess());
      } else {
        emit(BookingFailure("Please complete all fields."));
      }
    }
  }
}
