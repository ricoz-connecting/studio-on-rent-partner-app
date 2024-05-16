import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/stores/domain/repository/add_studio_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetStudioDetails
    implements Usecases<String, FutureEitherFailure<StudioDetails>> {
  final AddStudioRepository addStudioRepository;

  GetStudioDetails({required this.addStudioRepository});
  @override
  FutureEitherFailure<StudioDetails> call(String params) {
    // TODO: implement call
    return addStudioRepository.getStudioDetails(params);
  }
}
