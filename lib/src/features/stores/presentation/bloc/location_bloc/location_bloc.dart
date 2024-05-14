import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/location_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/usecase/get_user_location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetUserLocation _getUserLocation;
  LocationBloc({required GetUserLocation getUserLocation})
      : _getUserLocation = getUserLocation,
        super(LocationInitial()) {
    on<LocationEvent>((event, emit) {
      emit(LoadingState());
    });
    on<GetLocationAuto>(
      (event, emit) async {
        final res = await _getUserLocation.call(null);
        res.fold((l) => emit(LocationFailure(message: l.message)),
            (r) => emit(LocationSuccessState(locationEntity: r)));
      },
    );
  }
}
