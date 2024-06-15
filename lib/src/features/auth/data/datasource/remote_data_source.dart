import 'dart:convert';
import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studio_partner_app/src/commons/exceptions/api_exception.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';

import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthDataSource {
  FutureEitherFailure<String> getOtp(String params);
  FutureEitherFailure<String> isVerified(String params);
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  FutureEitherFailure<String> getOtp(String params) async {
    log(params);

    try {
      final response = await http.get(
          Uri.parse("${AppUrls.baseUrl}${AppUrls.otpEndPoint}?params=$params"));
      if (response.statusCode == 200) {
        log(response.body);
        final data = jsonDecode(response.body);
        final otp = data["otp"];
        // newUser = data["newUser"];
        final newAgent = data['newAgent'];
        if (!newAgent) {
          globalAgentId = data['agentId'];
          await Hive.box('USER').put('agentId', globalAgentId);
        }
        return Right(otp);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      log(e.message);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      print(e);

      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<String> isVerified(String params) async {
    try {
      final response = await http.get(
          Uri.parse("${AppUrls.baseUrl}${AppUrls.isVerified}/$globalAgentId"));
      if (response.statusCode == 200) {
        log(response.body);

        final body = jsonDecode(response.body);
        final isVerified = body['isVerified'];
        globalAgentModel = AgentModel.fromMap(body['agent_details']);
        return Right(isVerified);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      return Left(ApiFailure(messages: e.toString()));
    }
  }
}
