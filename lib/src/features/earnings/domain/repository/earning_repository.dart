import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/features/earnings/domain/entity/payment_entity.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

abstract interface class EarningRepository {
  FutureEitherFailure<Earnings> getEarnings(String agentId);
  FutureEitherFailure<List<ReviewModel>> getReviews(String agentId);
  FutureEitherFailure<AgentModel> makePayment(PaymentParams bank);
}
