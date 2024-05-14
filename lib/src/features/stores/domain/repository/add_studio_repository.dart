import 'package:studio_partner_app/src/features/stores/domain/entity/category_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/location_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

abstract interface class AddStudioRepository {
  FutureEitherFailure<LocationEntity> getUserLocation();
  FutureEitherFailure<List<CategoryEntity>> getCategorydata();
}
