import 'package:studio_partner_app/src/commons/params/register_params.dart';
import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/register/domain/repository/register_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class RegisterUsecase
    implements Usecases<RegisterParams, FutureEitherFailure<String>> {
  final RegisterRepository registerRepository;

  RegisterUsecase({required this.registerRepository});
  @override
  FutureEitherFailure<String> call(RegisterParams params) {
    return registerRepository.regiseterSuccess(params);
  }
}
