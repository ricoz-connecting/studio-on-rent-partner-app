
part of 'map_bloc.dart';

@immutable
sealed class MapState {}

final class MapInitial extends MapState {}

class UpdateMapState extends MapState {
  final LatLng latLng;

  UpdateMapState({required this.latLng});
}
