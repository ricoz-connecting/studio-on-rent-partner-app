import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/features/profile/data/datasource/update_data_source.dart';
import 'package:studio_partner_app/src/features/profile/domain/entity/bank_entity.dart';
import 'package:studio_partner_app/src/features/profile/domain/repository/update_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class UpdateRepositoryImpl implements UpdateRepository {
  final UpdateDataSource updateDataSource;

  UpdateRepositoryImpl({required this.updateDataSource});
  @override
  FutureEitherFailure<AgentModel> updateAgentData(AgentUpdateParams params) {
    return updateDataSource.updateAgentData(params);
  }

  @override
  FutureEitherFailure<List<BankEntity>> getBankDetails(String params) {
    // TODO: implement getBankDetails
    return updateDataSource.getBankDetails(params);
  }

  @override
  FutureEitherFailure<List<BankEntity>> addBankDetails(BankParams params) {
    // TODO: implement addBankDetails
    return updateDataSource.addBankDetails(params);
  }
}
