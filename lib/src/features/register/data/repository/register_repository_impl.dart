import 'dart:developer';

import 'package:studio_partner_app/src/commons/params/register_params.dart';
import 'package:studio_partner_app/src/features/register/data/datasource/remote_data_source.dart';
import 'package:studio_partner_app/src/features/register/domain/repository/register_repository.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RemoteDataSource remoteDataSource;

  RegisterRepositoryImpl({required this.remoteDataSource});
  @override
  FutureEitherFailure<String> regiseterSuccess(RegisterParams params) async {
    // TODO: implement regiseterSuccess
    
    return await remoteDataSource.regiseterSuccess(params);
  }
}
