import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/features/profile/domain/entity/bank_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

abstract class UpdateRepository {
  FutureEitherFailure<AgentModel> updateAgentData(AgentUpdateParams params);
  FutureEitherFailure<List<BankEntity>> getBankDetails(String params);
  FutureEitherFailure<List<BankEntity>> addBankDetails(BankParams params);
}
