// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/features/profile/domain/entity/bank_entity.dart';
import 'package:studio_partner_app/src/features/profile/domain/usecase/add_bank.dart';

import 'package:studio_partner_app/src/features/profile/domain/usecase/get_bank_details.dart';

part 'bank_details_event.dart';
part 'bank_details_state.dart';

class BankDetailsBloc extends Bloc<BankDetailsEvent, BankDetailsState> {
  final GetBankDetails _getBankDetails;
  final AddBank _addBank;
  BankDetailsBloc({
    required GetBankDetails getBankDetails,required AddBank addBank,
  })  : _getBankDetails = getBankDetails,
  _addBank = addBank,
        super(BankDetailsInitial()) {
    on<BankDetailsEvent>((event, emit) {
      emit(BankDetailsLoadingState());
    });
    on<GetBankDetailsEvent>(
      (event, emit) async {
        final res = await _getBankDetails.call(event.agentId);
        res.fold((l) => emit(BankDetailsFailureState(message: l.message)),
            (r) => emit(BankDetailsSuccessState(banks: r)));
      },
    );

     on<AddBankDetailsEvent>(
      (event, emit) async {
        final res = await _addBank.call(event.bankParams);
        res.fold((l) => emit(BankDetailsFailureState(message: l.message)),
            (r) => emit(BankDetailsSuccessState(banks: r)));
      },
    );
  }
}
