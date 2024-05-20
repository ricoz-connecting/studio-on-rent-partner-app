part of 'earning_bloc.dart';

@immutable
sealed class EarningEvent {}

class GetEarningEvent extends EarningEvent {
  final String agentId;

  GetEarningEvent({required this.agentId});
}
