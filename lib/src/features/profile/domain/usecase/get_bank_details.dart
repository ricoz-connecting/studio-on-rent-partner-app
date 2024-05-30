import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/profile/domain/entity/bank_entity.dart';
import 'package:studio_partner_app/src/features/profile/domain/repository/update_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetBankDetails
    implements Usecases<String, FutureEitherFailure<List<BankEntity>>> {
  final UpdateRepository updateRepository;

  GetBankDetails({required this.updateRepository});
  @override
  FutureEitherFailure<List<BankEntity>> call(String params) {
    // TODO: implement call
    return updateRepository.getBankDetails(params);
  }
}
