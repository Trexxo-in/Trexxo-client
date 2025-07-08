import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trexxo_mobility/models/waypoint_model.dart';

class RideRequestCubit extends Cubit<RideRequestState> {
  RideRequestCubit() : super(const RideRequestState());

  void setPickup(WayPoint pickup) {
    emit(state.copyWith(pickup: pickup));
  }

  void setDropoff(WayPoint dropoff) {
    emit(state.copyWith(dropoff: dropoff));
  }

  void clearPickup() {
    emit(state.copyWith(clearPickup: true));
  }

  void clearDropoff() {
    emit(state.copyWith(clearDropoff: true));
  }

  void clearLocations() {
    emit(const RideRequestState()); // clears both
  }
}

@immutable
class RideRequestState {
  final WayPoint? pickup;
  final WayPoint? dropoff;

  const RideRequestState({this.pickup, this.dropoff});

  RideRequestState copyWith({
    WayPoint? pickup,
    bool clearPickup = false,
    WayPoint? dropoff,
    bool clearDropoff = false,
  }) {
    return RideRequestState(
      pickup: clearPickup ? null : pickup ?? this.pickup,
      dropoff: clearDropoff ? null : dropoff ?? this.dropoff,
    );
  }
}
