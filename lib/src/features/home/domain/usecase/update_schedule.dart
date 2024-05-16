import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/schedule_entity.dart';
import 'package:studio_partner_app/src/features/home/domain/repository/bookings_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class UpdateSchedule
    implements
        Usecases<UpdateParams, FutureEitherFailure<List<ScheduleEntity>>> {
  final BookingsRepository bookingsRepository;

  UpdateSchedule({required this.bookingsRepository});
  @override
  FutureEitherFailure<List<ScheduleEntity>> call(UpdateParams params) {
    return bookingsRepository.updateSchedules(params);
  }
}
