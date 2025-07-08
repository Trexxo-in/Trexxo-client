import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trexxo_mobility/models/waypoint_model.dart';

class LocationState extends Equatable {
  final LatLng? lastKnownLocation;
  final Set<WayPoint> history;

  const LocationState({this.lastKnownLocation, this.history = const {}});

  factory LocationState.initial() => const LocationState();

  LocationState copyWith({LatLng? lastKnownLocation, Set<WayPoint>? history}) {
    return LocationState(
      lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
      history: history ?? this.history,
    );
  }

  @override
  List<Object?> get props => [lastKnownLocation, history];
}

class LocationCubit extends HydratedCubit<LocationState> {
  LocationCubit() : super(LocationState.initial());

  void updateLocation(LatLng newLocation, WayPoint waypoint) {
    final updatedHistory = {...state.history, waypoint};
    emit(
      state.copyWith(lastKnownLocation: newLocation, history: updatedHistory),
    );
  }

  void addToHistory(WayPoint wp) {
    final newHistory = Set<WayPoint>.from(state.history)..add(wp);
    emit(state.copyWith(history: newHistory));
  }

  @override
  LocationState fromJson(Map<String, dynamic> json) {
    final coords = json['lastKnownLocation'];
    final historyJson = json['history'] as List<dynamic>?;

    final lastLoc =
        coords != null ? LatLng(coords['latitude'], coords['longitude']) : null;

    final history =
        historyJson != null
            ? historyJson.map((e) => WayPoint.fromJson(e)).toSet()
            : <WayPoint>{};

    return LocationState(lastKnownLocation: lastLoc, history: history);
  }

  @override
  Map<String, dynamic>? toJson(LocationState state) {
    final location = state.lastKnownLocation;
    return {
      'lastKnownLocation':
          location != null
              ? {'latitude': location.latitude, 'longitude': location.longitude}
              : null,
      'history': state.history.map((e) => e.toJson()).toList(),
    };
  }
}
