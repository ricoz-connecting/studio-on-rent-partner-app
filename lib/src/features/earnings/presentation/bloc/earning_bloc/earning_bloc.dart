import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/features/earnings/domain/entity/payment_entity.dart';
import 'package:studio_partner_app/src/features/earnings/domain/usecase/earnings_usecase.dart';

part 'earning_event.dart';
part 'earning_state.dart';

class EarningBloc extends Bloc<EarningEvent, EarningState> {
  final EarningsUsecase _earningsUsecase;
  EarningBloc({required EarningsUsecase earningsUsecase})
      : _earningsUsecase = earningsUsecase,
        super(EarningInitial()) {
    on<EarningEvent>((event, emit) {
      emit(EarningLoadingState());
    });

    on<GetEarningEvent>(
      (event, emit) async {
        final res = await _earningsUsecase.call(event.agentId);
        res.fold((l) => emit(EarningErrorState(message: l.message)),
            (r) => emit(EarningSuccessState(earnings: r)));
      },
    );
  }
}
