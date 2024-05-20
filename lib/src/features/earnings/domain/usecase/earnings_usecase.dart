import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/earnings/domain/entity/payment_entity.dart';
import 'package:studio_partner_app/src/features/earnings/domain/repository/earning_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class EarningsUsecase
    implements Usecases<String, FutureEitherFailure<Earnings>> {
  final EarningRepository earningRepository;

  EarningsUsecase({required this.earningRepository});

  @override
  FutureEitherFailure<Earnings> call(String params) {
    return earningRepository.getEarnings(params);
  }
}
