// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bank_details_bloc.dart';

@immutable
sealed class BankDetailsState {}

final class BankDetailsInitial extends BankDetailsState {}

class BankDetailsLoadingState extends BankDetailsState {}

class BankDetailsFailureState extends BankDetailsState {
  final String message;

  BankDetailsFailureState({required this.message});
}

class BankDetailsSuccessState extends BankDetailsState {
  final List<BankEntity> banks;
  BankDetailsSuccessState({
    required this.banks,
  });
}
