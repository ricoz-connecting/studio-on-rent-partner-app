import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/features/home/domain/repository/bookings_repository.dart';
import 'package:studio_partner_app/src/features/home/domain/usecase/get_stores.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetStores _getStores;
  StoreBloc({required GetStores getStores})
      : _getStores = getStores,
        super(StoreInitial()) {
    on<StoreEvent>((event, emit) {
      // TODO: implement event handler
      emit(StoreLoadingState());
    });
    on<GetStoreEvent>(
      (event, emit) async {
        final res = await _getStores.call(event.agentId);
        res.fold((l) => emit(StoreFailureState(message: l.message)),
            (r) => emit(StoreSuccessState(studios: r)));
      },
    );
  }
}
