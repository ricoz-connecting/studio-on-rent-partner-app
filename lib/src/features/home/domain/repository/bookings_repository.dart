import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/features/home/data/model/chat_model.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/schedule_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

abstract interface class BookingsRepository {
  FutureEitherFailure<List<ScheduleEntity>> getSchedules(String agentId);
   FutureEitherFailure<List<ScheduleEntity>> updateSchedules(UpdateParams params);
     FutureEitherFailure<List<ChatModel>> getChats(String agentId);
  FutureEitherFailure<List<StudioEntity>> getStores(String agentId);

}
