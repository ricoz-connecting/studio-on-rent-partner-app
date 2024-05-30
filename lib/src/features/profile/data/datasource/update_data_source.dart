import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:studio_partner_app/src/commons/exceptions/api_exception.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/features/profile/data/models/bank_model.dart';
import 'package:studio_partner_app/src/features/profile/prsesntation/widgets/bank_details.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';
import 'package:http/http.dart' as http;

abstract class UpdateDataSource {
  FutureEitherFailure<AgentModel> updateAgentData(AgentUpdateParams params);
  FutureEitherFailure<List<BankModel>> getBankDetails(String params);
  FutureEitherFailure<List<BankModel>> addBankDetails(BankParams params);
}

class UpdateDataSourceImpl implements UpdateDataSource {
  @override
  FutureEitherFailure<AgentModel> updateAgentData(
      AgentUpdateParams params) async {
    try {
      final map = jsonEncode(params.toMap());

      final request = http.MultipartRequest(
        'POST',
        Uri.parse("${AppUrls.baseUrl}${AppUrls.update}/$globalAgentId"),
      );
      request.files
          .addAll([http.MultipartFile.fromBytes('photoUrl', params.photoUrl)]);
      request.fields.addAll({'fields': map});
      final response = await request.send();
      if (response.statusCode == 200) {
        final body = jsonDecode(await response.stream.bytesToString());
        globalAgentModel = AgentModel.fromMap(body);
        print(globalAgentId.toString());
        return Right(globalAgentModel!);
      } else {
        throw ApiException(message: await response.stream.bytesToString());
      }
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(messages: e.toString()));
    } catch (e) {
      print(e.toString());
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<BankModel>> getBankDetails(String params) async {
    try {
      final response = await http.get(Uri.parse(
          "${AppUrls.baseUrl}${AppUrls.bankDetailsEndPoint}/$params"));

      if (response.statusCode == 200) {
        log(jsonDecode(response.body).toString());

        final List<Map<String, dynamic>> body =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));

        final banks = body.map((e) => BankModel.fromMap(e)).toList();
        return Right(banks);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<BankModel>> addBankDetails(BankParams params) async {
    try {
      print(params.toMap());
      final response = await http.post(
        Uri.parse(
            "${AppUrls.baseUrl}${AppUrls.addBankDetailsEndPoint}/${params.agentId}"),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(params.toMap()),
      );
      if (response.statusCode == 200) {
        final body =
            jsonDecode(jsonEncode(response.body)) as List<Map<String, dynamic>>;
        final banks = body.map((e) => BankModel.fromMap(e)).toList();
        return Right(banks);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      return Left(ApiFailure(messages: e.toString()));
    }
  }
}
