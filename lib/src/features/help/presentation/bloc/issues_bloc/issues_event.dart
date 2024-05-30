part of 'issues_bloc.dart';

@immutable
sealed class IssuesEvent {}

class GetIssuesEvent extends IssuesEvent {
  final String agentId;

  GetIssuesEvent({required this.agentId});
}

class SendIssuesEvent extends IssuesEvent {
  final TableModel tableEntity;

  SendIssuesEvent({required this.tableEntity}); 
}
