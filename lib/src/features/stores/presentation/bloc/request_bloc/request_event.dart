part of 'request_bloc.dart';

@immutable
sealed class RequestEvent {}

class StudioAddRequestEvent extends RequestEvent {
  final StudioParams studioParams;

  StudioAddRequestEvent({required this.studioParams});
}
