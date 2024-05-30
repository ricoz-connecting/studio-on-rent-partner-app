part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class UpdateAgentEvent extends UpdateEvent {
  final AgentUpdateParams agentUpdateParams;

  UpdateAgentEvent({required this.agentUpdateParams});
}
