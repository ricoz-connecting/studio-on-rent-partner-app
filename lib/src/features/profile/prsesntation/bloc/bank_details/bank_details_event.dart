part of 'bank_details_bloc.dart';

@immutable
sealed class BankDetailsEvent {}

class GetBankDetailsEvent extends BankDetailsEvent {
  final String agentId;

  GetBankDetailsEvent({required this.agentId});
}

class AddBankDetailsEvent extends BankDetailsEvent {
  final BankParams bankParams;

  AddBankDetailsEvent({required this.bankParams});

}
