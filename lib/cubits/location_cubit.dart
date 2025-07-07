import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationState extends Equatable {
  final LatLng? lastKnownLocation;

  const LocationState({this.lastKnownLocation});

  factory LocationState.initial() => const LocationState();

  LocationState copyWith({LatLng? lastKnownLocation}) {
    return LocationState(
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    );
  }

  @override
  List<Object?> get props => [lastKnownLocation];
}

class LocationCubit extends HydratedCubit<LocationState> {
  LocationCubit() : super(LocationState.initial());

  void updateLocation(LatLng newLocation) {
    emit(state.copyWith(lastKnownLocation: newLocation));
  }

  @override
  LocationState fromJson(Map<String, dynamic> json) {
    final coords = json['lastKnownLocation'];
    if (coords is Map<String, dynamic>) {
      return LocationState(
        lastKnownLocation: LatLng(
          coords['latitude'] as double,
          coords['longitude'] as double,
        ),
      );
    }
    return LocationState.initial();
  }

  @override
  Map<String, dynamic>? toJson(LocationState state) {
    final location = state.lastKnownLocation;
    return {
      'lastKnownLocation':
          location != null
              ? {'latitude': location.latitude, 'longitude': location.longitude}
              : null,
    };
  }
}
