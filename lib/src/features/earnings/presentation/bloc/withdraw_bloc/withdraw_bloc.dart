import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/features/earnings/domain/repository/earning_repository.dart';
import 'package:studio_partner_app/src/features/earnings/domain/usecase/earnings_usecase.dart';
import 'package:studio_partner_app/src/features/earnings/domain/usecase/payment_usecase.dart';

part 'withdraw_event.dart';
part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  final PaymentUsecase _paymentUsecase;
  WithdrawBloc({required PaymentUsecase paymentUsecase})
      : _paymentUsecase = paymentUsecase,
        super(WithdrawInitial()) {
    on<WithdrawEvent>((event, emit) {
      // TODO: implement event handler
      emit(WithdrawlLoadingState());
    });
    on<WithdrawAmountEvent>(
      (event, emit) async {
        final res = await _paymentUsecase.call(event.bank);
        res.fold((l) => emit(WithdrawlFailureState(message: l.message)),
            (r) => emit(WithdrawlSuccessState(agentModel: r)));
      },
    );
  }
}
