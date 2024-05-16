part of 'studio_bloc.dart';

@immutable
sealed class StudioEvent {}

class GetStudioDataEvent extends StudioEvent {
  final String studioId;

  GetStudioDataEvent({required this.studioId});
}
