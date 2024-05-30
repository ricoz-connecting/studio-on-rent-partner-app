import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:studio_partner_app/src/commons/exceptions/api_exception.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/features/help/data/model/help_model.dart';
import 'package:studio_partner_app/src/features/help/data/model/table_model.dart';
import 'package:studio_partner_app/src/features/help/domain/entity/table_entity.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';
import 'package:http/http.dart' as http;

abstract class HelpDataSource {
  FutureEitherFailure<List<HelpModel>> getHelps();
  FutureEitherFailure<List<TableModel>> getIssues();
  FutureEitherFailure<List<TableModel>> sendIssues(TableModel table);
}

class HelpDataSourceImpl implements HelpDataSource {
  @override
  FutureEitherFailure<List<HelpModel>> getHelps() async {
    try {
      final response =
          await http.get(Uri.parse("${AppUrls.baseUrl}${AppUrls.help}/_"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final helpModels =
            data.map<HelpModel>((e) => HelpModel.fromMap(e)).toList();
        return Right(helpModels);
      } else {
        throw ApiException();
      }
    } catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<TableModel>> getIssues() async {
    try {
      final response = await http.get(Uri.parse(
          "${AppUrls.baseUrl}${AppUrls.issuesEndPoint}/$globalAgentId"));
      if (response.statusCode == 200) {
        log(response.body);
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
        final tableData = data.map((e) => TableModel.fromMap(e)).toList();

        return Right(tableData);
      } else {
        throw ApiException();
      }
    } catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<TableModel>> sendIssues(
      TableModel tablemodel) async {
    try {
      final response = await http.post(
          Uri.parse(
              "${AppUrls.baseUrl}${AppUrls.issuesEndPoint}/$globalAgentId"),
          headers: {"content-type": "application/json"},
          body: jsonEncode(tablemodel.toMap()));
      if (response.statusCode == 200) {
        log(response.body);
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
        final tableData = data.map((e) => TableModel.fromMap(e)).toList();
        return Right(tableData);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      log(e.message);
      return Left(ApiFailure(messages: e.toString()));
    }
  }
}
