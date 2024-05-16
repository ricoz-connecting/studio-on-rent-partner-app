part of 'schedules_bloc.dart';

@immutable
sealed class SchedulesEvent {}

class GetScheduleEvent extends SchedulesEvent {
  final String agentId;

  GetScheduleEvent({required this.agentId});
}

class UpdateScheduleEvent extends SchedulesEvent {
  final UpdateParams params;

  UpdateScheduleEvent({required this.params});
}
