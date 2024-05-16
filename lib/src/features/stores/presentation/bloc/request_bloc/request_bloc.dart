import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/commons/params/studio_params.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/post_studio_request.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final PostStudioRequest _postStudioRequest;
  RequestBloc({required PostStudioRequest postStudioRequest})
      : _postStudioRequest = postStudioRequest,
        super(RequestInitial()) {
    on<RequestEvent>((event, emit) {
      emit(RequestLoadingState());
    });
    on<StudioAddRequestEvent>(
      (event, emit) async {
        final res = await _postStudioRequest.call(event.studioParams);
        res.fold((l) => emit(RequestFailureState(message: l.message)),
            (r) => emit(RequestSuccessState(studioEntity: r)));
      },
    );
  }
}
