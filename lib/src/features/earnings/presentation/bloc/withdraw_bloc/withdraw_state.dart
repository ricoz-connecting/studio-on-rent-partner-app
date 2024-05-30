part of 'withdraw_bloc.dart';

@immutable
sealed class WithdrawState {}

final class WithdrawInitial extends WithdrawState {}

class WithdrawlSuccessState extends WithdrawState {
  final AgentModel agentModel;

  WithdrawlSuccessState({required this.agentModel});
}

class WithdrawlFailureState extends WithdrawState {
  final String message;

  WithdrawlFailureState({required this.message});
}

class WithdrawlLoadingState extends WithdrawState {}
