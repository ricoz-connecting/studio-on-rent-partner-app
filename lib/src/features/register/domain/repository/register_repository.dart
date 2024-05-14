import 'package:studio_partner_app/src/commons/params/register_params.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

abstract interface class RegisterRepository {
  FutureEitherFailure<String> regiseterSuccess(RegisterParams params);
}
