part of 'schedules_bloc.dart';

@immutable
sealed class SchedulesState {}

final class SchedulesInitial extends SchedulesState {}

class ScheduleLoadingState extends SchedulesState {}

class ScheduleSuccessState extends SchedulesState {
  final List<ScheduleEntity> schedules;

  ScheduleSuccessState({required this.schedules});
}

class ScheduleFailureState extends SchedulesState {
  final String message;

  ScheduleFailureState({required this.message});
}
