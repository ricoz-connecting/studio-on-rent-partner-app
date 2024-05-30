import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/features/profile/domain/repository/update_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class UpdateUsecase implements Usecases<AgentUpdateParams, FutureEitherFailure<AgentModel>> {
  final UpdateRepository updateRepository;

  UpdateUsecase({required this.updateRepository});
  @override
  FutureEitherFailure<AgentModel> call(AgentUpdateParams params) {
    return updateRepository.updateAgentData(params);
  }
}
