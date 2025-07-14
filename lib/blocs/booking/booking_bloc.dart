import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_event.dart';
import 'booking_state.dart';
import 'package:trexxo_mobility/models/waypoint_model.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<BookingStarted>(_onStarted);
    on<PickupLocationSelected>(_onPickupSelected);
    on<DropoffLocationSelected>(_onDropoffSelected);
    on<BookingServiceTypeSelected>(_onServiceTypeSelected);
    on<BookingDetailsSubmitted>(_onSubmitted);
  }

  WayPoint? _pickup;
  WayPoint? _dropoff;

  void _onStarted(BookingStarted event, Emitter<BookingState> emit) {
    log('Booking session started', name: 'BookingBloc');
    _pickup = null;
    _dropoff = null;
    emit(BookingInitial());
  }

  void _onPickupSelected(
    PickupLocationSelected event,
    Emitter<BookingState> emit,
  ) {
    _pickup = event.pickupLocation;
    log('Pickup selected: $_pickup', name: 'BookingBloc');

    if (_pickup != null && _dropoff != null) {
      emit(LocationSelectedState(pickup: _pickup!, dropoff: _dropoff!));
      log(
        'Both pickup and dropoff selected. Emitting LocationSelectedState.',
        name: 'BookingBloc',
      );
    }
  }

  void _onDropoffSelected(
    DropoffLocationSelected event,
    Emitter<BookingState> emit,
  ) {
    _dropoff = event.dropoffLocation;
    log('Dropoff selected: $_dropoff', name: 'BookingBloc');

    if (_pickup != null && _dropoff != null) {
      emit(LocationSelectedState(pickup: _pickup!, dropoff: _dropoff!));
      log(
        'Both pickup and dropoff selected. Emitting LocationSelectedState.',
        name: 'BookingBloc',
      );
    }
  }

  void _onServiceTypeSelected(
    BookingServiceTypeSelected event,
    Emitter<BookingState> emit,
  ) {
    log('Service type selected: ${event.serviceType}', name: 'BookingBloc');

    if (state is LocationSelectedState) {
      final locationState = state as LocationSelectedState;

      emit(
        ServiceTypeSelectedState(
          pickup: locationState.pickup,
          dropoff: locationState.dropoff,
          serviceType: event.serviceType,
        ),
      );
      log('Transitioned to ServiceTypeSelectedState', name: 'BookingBloc');
    } else {
      emit(BookingErrorState("Please select both pickup and dropoff first."));
      log(
        'Error: Tried selecting service type before setting locations',
        name: 'BookingBloc',
      );
    }
  }

  void _onSubmitted(BookingDetailsSubmitted event, Emitter<BookingState> emit) {
    if (state is ServiceTypeSelectedState) {
      final s = state as ServiceTypeSelectedState;
      log(
        "Booking submitted:\nPickup: ${s.pickup}\nDropoff: ${s.dropoff}\nServiceType: ${s.serviceType}",
        name: 'BookingBloc',
      );
      emit(BookingDetailsSubmittedState());
    } else {
      emit(BookingErrorState("Missing data. Cannot submit booking."));
      log(
        'Error: Tried to submit booking in invalid state: $state',
        name: 'BookingBloc',
      );
    }
  }
}
