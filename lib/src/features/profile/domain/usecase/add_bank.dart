import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/profile/domain/entity/bank_entity.dart';
import 'package:studio_partner_app/src/features/profile/domain/repository/update_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class AddBank
    implements Usecases<BankParams, FutureEitherFailure<List<BankEntity>>> {
  final UpdateRepository updateRepository;

  AddBank({required this.updateRepository});
  @override
  FutureEitherFailure<List<BankEntity>> call(BankParams params) {
    // TODO: implement call
    return updateRepository.addBankDetails(params);
  }
}
