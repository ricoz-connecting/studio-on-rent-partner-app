import 'package:studio_partner_app/src/res/typedefs.dart';

abstract interface class AuthRepository {
  FutureEitherFailure<String> getOtp(String params);
  FutureEitherFailure<String> isVerified(String params);
}
