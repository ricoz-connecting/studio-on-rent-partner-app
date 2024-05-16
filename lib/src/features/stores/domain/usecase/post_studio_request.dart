import 'package:studio_partner_app/src/commons/params/studio_params.dart';
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/stores/domain/entity/studio_entity.dart';
import 'package:studio_partner_app/src/features/stores/domain/repository/add_studio_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class PostStudioRequest implements Usecases<StudioParams, FutureEitherFailure<StudioEntity>> {
  final AddStudioRepository addStudioRepository;

  PostStudioRequest({required this.addStudioRepository});
  @override
  FutureEitherFailure<StudioEntity> call(StudioParams params) async{
    return await addStudioRepository.submitStudioRequest(params);
  }
}
