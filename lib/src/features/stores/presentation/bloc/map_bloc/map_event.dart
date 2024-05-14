// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

// ignore: must_be_immutable
class UpdateMap extends MapEvent {
  LatLng latLng;
  UpdateMap({
    required this.latLng,
  });
}
