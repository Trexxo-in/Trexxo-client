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

  void clearLocations() {
    emit(const RideRequestState());
  }
}

@immutable
class RideRequestState {
  final WayPoint? pickup;
  final WayPoint? dropoff;

  const RideRequestState({this.pickup, this.dropoff});

  RideRequestState copyWith({WayPoint? pickup, WayPoint? dropoff}) {
    return RideRequestState(
      pickup: pickup ?? this.pickup,
      dropoff: dropoff ?? this.dropoff,
    );
  }
}
