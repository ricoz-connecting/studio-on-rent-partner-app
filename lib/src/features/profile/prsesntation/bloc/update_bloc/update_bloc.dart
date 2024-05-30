import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/features/profile/domain/usecase/update_usecase.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final UpdateUsecase _updateUsecase;
  UpdateBloc({required UpdateUsecase updateUsecase})
      : _updateUsecase = updateUsecase,
        super(UpdateInitial()) {
    on<UpdateEvent>((event, emit) {
      emit(UpdateLoadingState());
    });

    on<UpdateAgentEvent>(
      (event, emit) async {
        final res = await _updateUsecase.call(event.agentUpdateParams);
        res.fold((l) => emit(UpdateFailureState(message: l.message)),
            (r) => emit(UpdateSuccessState(agentModel: r)));
      },
    );
  }
}
