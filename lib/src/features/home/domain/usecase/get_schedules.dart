
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/schedule_entity.dart';
import 'package:studio_partner_app/src/features/home/domain/repository/bookings_repository.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetSchedules
    implements Usecases<String, FutureEitherFailure<List<ScheduleEntity>>> {
  final BookingsRepository bookingsRepository;

  GetSchedules({required this.bookingsRepository});

  @override
  FutureEitherFailure<List<ScheduleEntity>> call(String params) {
    return bookingsRepository.getSchedules(params);
  }
}
