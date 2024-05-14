part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}
final class LoadingState extends LocationState{}
class LocationSuccessState extends LocationState {
  final LocationEntity locationEntity;

  LocationSuccessState({required this.locationEntity});
}

class LocationFailure extends LocationState {
  final String message;

  LocationFailure({required this.message});
}
