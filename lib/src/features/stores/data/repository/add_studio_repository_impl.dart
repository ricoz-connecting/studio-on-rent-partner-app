import 'package:studio_partner_app/src/features/stores/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/stores/data/model/location_model.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/category_entity.dart';
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
}
