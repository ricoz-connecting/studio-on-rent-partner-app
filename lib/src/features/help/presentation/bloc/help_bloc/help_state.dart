part of 'help_bloc.dart';

@immutable
sealed class HelpState {}

final class HelpInitial extends HelpState {}

class HelpSuccessState extends HelpState {
  final List<HelpEntity> helps;

  HelpSuccessState({required this.helps});
}

class HelpFailureState extends HelpState {
  final String message;

  HelpFailureState({required this.message});
}

class HelpLoadingState extends HelpState {}
