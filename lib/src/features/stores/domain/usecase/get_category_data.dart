import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/category_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/repository/add_studio_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetCategoryData  implements Usecases<Null, FutureEitherFailure<List<CategoryEntity>>> {
  final AddStudioRepository addStudioRepository;

  GetCategoryData({required this.addStudioRepository});
  @override
  FutureEitherFailure<List<CategoryEntity>> call(Null params) {
    return addStudioRepository.getCategorydata();
  }
}