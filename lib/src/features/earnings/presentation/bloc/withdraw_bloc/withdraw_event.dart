part of 'withdraw_bloc.dart';

@immutable
sealed class WithdrawEvent {}

class WithdrawAmountEvent implements WithdrawEvent {
  final PaymentParams bank;

  WithdrawAmountEvent({required this.bank});
}
