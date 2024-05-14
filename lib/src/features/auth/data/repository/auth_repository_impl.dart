import 'package:studio_partner_app/src/features/auth/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/auth/domain/repositorty/auth_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});
  @override
  FutureEitherFailure<String> getOtp(String params) {
    // TODO: implement getOtp
    return dataSource.getOtp(params);
  }

  @override
  FutureEitherFailure<String> isVerified(String params) {
    return dataSource.isVerified(params);
  }
}
