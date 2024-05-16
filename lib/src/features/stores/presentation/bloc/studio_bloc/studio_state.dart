part of 'studio_bloc.dart';

@immutable
sealed class StudioState {}

final class StudioInitial extends StudioState {}

class StudioLoadingState extends StudioState {}

class StudioSuccessState extends StudioState {
  final StudioDetails studioDetails;

  StudioSuccessState({required this.studioDetails});
}

class StudioFailureState extends StudioState {
  final String message;

  StudioFailureState({required this.message});
}
