import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/home/domain/repository/bookings_repository.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetStores
    implements Usecases<String, FutureEitherFailure<List<StudioEntity>>> {
  final BookingsRepository bookingsRepository;

  GetStores({required this.bookingsRepository});

  @override
  FutureEitherFailure<List<StudioEntity>> call(String params) {
    // TODO: implement call
    return bookingsRepository.getStores(params);
  }
}
