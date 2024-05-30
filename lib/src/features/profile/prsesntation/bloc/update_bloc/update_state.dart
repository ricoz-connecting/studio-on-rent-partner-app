part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {}

class UpdateLoadingState extends UpdateState {}

class UpdateSuccessState extends UpdateState {
  final AgentModel agentModel;

  UpdateSuccessState({required this.agentModel});
}

class UpdateFailureState extends UpdateState {
  final String message;

  UpdateFailureState({required this.message});
}