import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/location_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/repository/add_studio_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetUserLocation
    implements Usecases<Null, FutureEitherFailure<LocationEntity>> {
  final AddStudioRepository addStudioRepository;

  GetUserLocation({required this.addStudioRepository});
  @override
  FutureEitherFailure<LocationEntity> call(Null params) {
    return addStudioRepository.getUserLocation();
  }
}
