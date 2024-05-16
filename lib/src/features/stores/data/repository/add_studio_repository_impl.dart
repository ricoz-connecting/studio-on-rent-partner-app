import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/commons/params/studio_params.dart';
import 'package:studio_partner_app/src/features/stores/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/stores/data/model/location_model.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/category_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/repository/add_studio_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class AddStudioRepositoryImpl implements AddStudioRepository {
  final StoreRemoteDataSource remoteDataSource;

  AddStudioRepositoryImpl({required this.remoteDataSource});
  @override
  FutureEitherFailure<LocationModel> getUserLocation() async {
    return remoteDataSource.getUserLocation();
  }

  @override
  FutureEitherFailure<List<CategoryEntity>> getCategorydata() {
    return remoteDataSource.getCategorydata();
  }

  @override
  FutureEitherFailure<StudioEntity> submitStudioRequest(StudioParams params) {
    return remoteDataSource.submitStudioRequest(params);
  }

  @override
  FutureEitherFailure<StudioDetails> getStudioDetails(String studioId) {
    return remoteDataSource.getStudioDetails(studioId);
  }
}
