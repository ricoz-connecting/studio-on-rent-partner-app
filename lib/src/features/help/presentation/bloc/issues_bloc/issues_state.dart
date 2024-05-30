part of 'issues_bloc.dart';

@immutable
sealed class IssuesState {}

final class IssuesInitial extends IssuesState {}

class IssuesSuccessState extends IssuesState {
  final List<TableEntity> tables;

  IssuesSuccessState({required this.tables});
}

class IssuesLoadingState extends IssuesState {}

class IssuesFailureState extends IssuesState {
  final String message;

  IssuesFailureState({required this.message});
}
