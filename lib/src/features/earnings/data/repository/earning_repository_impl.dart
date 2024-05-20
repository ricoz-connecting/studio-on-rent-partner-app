import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/features/earnings/data/datasource/earning_data_source.dart';
import 'package:studio_partner_app/src/features/earnings/domain/entity/payment_entity.dart';
import 'package:studio_partner_app/src/features/earnings/domain/repository/earning_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class EarningRepositoryImpl implements EarningRepository {
  final EarningDataSource earningDataSource;

  EarningRepositoryImpl({required this.earningDataSource});
  @override
  FutureEitherFailure<Earnings> getEarnings(String agentId) {
    return earningDataSource.getEarnings(agentId);
  }

  @override
  FutureEitherFailure<List<ReviewModel>> getReviews(String agentId) {
    return earningDataSource.getReviews(agentId);
  }
}
