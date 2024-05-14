import 'package:studio_partner_app/src/commons/usecases/usecases.dart';
import 'package:studio_partner_app/src/features/auth/domain/repositorty/auth_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class GetOtp implements Usecases<String, FutureEitherFailure<String>> {
  final AuthRepository authRepository;

  GetOtp({required this.authRepository});
  @override
  FutureEitherFailure<String> call(String params) {
    return authRepository.getOtp(params);
  }
}

class IsVerified implements Usecases<String, FutureEitherFailure<String>> {
  final AuthRepository authRepository;

  IsVerified({required this.authRepository});

  @override
  FutureEitherFailure<String> call(String params) {
    return authRepository.isVerified(params);
  }
}
