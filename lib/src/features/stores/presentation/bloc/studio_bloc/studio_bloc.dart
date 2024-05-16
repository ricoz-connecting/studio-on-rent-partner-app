import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/get_studio_details.dart';

part 'studio_event.dart';
part 'studio_state.dart';

class StudioBloc extends Bloc<StudioEvent, StudioState> {
  final GetStudioDetails _getStudioDetails;
  StudioBloc({required GetStudioDetails getStudioDetails})
      : _getStudioDetails = getStudioDetails,
        super(StudioInitial()) {
    on<StudioEvent>((event, emit) {
      // TODO: implement event handler
      emit(StudioLoadingState());
    });

    on<GetStudioDataEvent>(
      (event, emit) async {
        final res = await _getStudioDetails.call(event.studioId);
        res.fold((l) => emit(StudioFailureState(message: l.message)),
            (r) => emit(StudioSuccessState(studioDetails: r)));
      },
    );
  }
}
