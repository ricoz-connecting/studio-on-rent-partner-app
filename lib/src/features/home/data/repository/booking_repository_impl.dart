import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/features/home/data/datasource/home_remote_data_source.dart';
import 'package:studio_partner_app/src/features/home/data/model/chat_model.dart';
import 'package:studio_partner_app/src/features/home/data/model/schedule_model.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/schedule_entity.dart';
import 'package:studio_partner_app/src/features/home/domain/repository/bookings_repository.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  BookingsRepositoryImpl({required this.homeRemoteDataSource});
  @override
  FutureEitherFailure<List<ScheduleModel>> getSchedules(String agentId) {
    return homeRemoteDataSource.getSchedules(agentId);
  }

  @override
  FutureEitherFailure<List<ScheduleModel>> updateSchedules(
      UpdateParams params) {
    return homeRemoteDataSource.updateSchedules(params);
  }

  @override
  FutureEitherFailure<List<ChatModel>> getChats(String agentId) {
    return homeRemoteDataSource.getChats(agentId);
  }

  @override
  FutureEitherFailure<List<StudioEntity>> getStores(String agentId) {
    return homeRemoteDataSource.getStores(agentId);
  }
}
