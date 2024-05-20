part of 'earning_bloc.dart';

@immutable
sealed class EarningState {}

final class EarningInitial extends EarningState {}

class EarningLoadingState extends EarningState {}

class EarningSuccessState extends EarningState {
  final Earnings earnings;

  EarningSuccessState({required this.earnings});
}

class EarningErrorState extends EarningState {
  final String message;

  EarningErrorState({required this.message});
}
