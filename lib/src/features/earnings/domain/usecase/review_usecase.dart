import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/earnings/domain/repository/earning_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class ReviewUsecase
    implements Usecases<String, FutureEitherFailure<List<ReviewModel>>> {
  final EarningRepository earningRepository;

  ReviewUsecase({required this.earningRepository});

  @override
  FutureEitherFailure<List<ReviewModel>> call(String params) {
    // TODO: implement call
    return earningRepository.getReviews(params);
  }
}
