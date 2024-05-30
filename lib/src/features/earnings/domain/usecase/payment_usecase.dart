import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/features/earnings/domain/repository/earning_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class PaymentUsecase
    implements Usecases<PaymentParams, FutureEitherFailure<AgentModel>> {
  final EarningRepository earningRepository;

  PaymentUsecase({required this.earningRepository});
  @override
  FutureEitherFailure<AgentModel> call(PaymentParams params) {
    // TODO: implement call
    return earningRepository.makePayment(params);
  }
}
