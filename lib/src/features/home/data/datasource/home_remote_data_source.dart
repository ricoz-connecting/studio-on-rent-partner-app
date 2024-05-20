import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:studio_partner_app/src/commons/exceptions/api_exception.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/params/update_params.dart';
import 'package:studio_partner_app/src/features/home/data/model/chat_model.dart';
import 'package:studio_partner_app/src/features/home/data/model/schedule_model.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/chat_entity.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/schedule_entity.dart';
import 'package:studio_partner_app/src/features/stores/data/model/studio_model.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';
import 'package:http/http.dart' as http;

abstract interface class HomeRemoteDataSource {
  FutureEitherFailure<List<ScheduleModel>> getSchedules(String agentId);
  FutureEitherFailure<List<ScheduleModel>> updateSchedules(UpdateParams params);
  FutureEitherFailure<List<ChatModel>> getChats(String agentId);
  FutureEitherFailure<List<StudioModel>> getStores(String agentId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  FutureEitherFailure<List<ScheduleModel>> getSchedules(String agentId) async {
    try {
      final response = await http.get(
          Uri.parse("${AppUrls.baseUrl}${AppUrls.homeViewEndPoint}/$agentId"));
      if (response.statusCode == 200) {
        log(response.body);
        final body = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        final listofSchedules =
            body.map<ScheduleModel>((e) => ScheduleModel.fromMap(e)).toList();
        return Right(listofSchedules);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      print(e.toString());
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<ScheduleModel>> updateSchedules(
      UpdateParams params) async {
    try {
      final response = await http.post(Uri.parse(
          "${AppUrls.baseUrl}${AppUrls.schedulesUpdateEndPoint}/$globalAgentId/${params.scheduleId}/${params.status}"));
      if (response.statusCode == 200) {
        final body = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        log(body.toString());
        final listofSchedules =
            body.map<ScheduleModel>((e) => ScheduleModel.fromMap(e)).toList();
        return Right(listofSchedules);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<ChatModel>> getChats(String agentId) async {
    try {
      final response = await http
          .get(Uri.parse("${AppUrls.baseUrl}${AppUrls.chat}/$agentId"));
      if (response.statusCode == 200) {
        final body = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        final listofSchedules =
            body.map<ChatModel>((e) => ChatModel.fromMap(e)).toList();
        return Right(listofSchedules);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<StudioModel>> getStores(String agentId) async {
    try {
      final response = await http.get(Uri.parse(
          "${AppUrls.baseUrl}${AppUrls.studioRequestEndPoint}/$agentId"));

      if (response.statusCode == 200) {
        final body = List<Map<String, dynamic>>.from(jsonDecode(response.body));

        final listofSchedules =
            body.map<StudioModel>((e) => StudioModel.fromMap(e)).toList();
        return Right(listofSchedules);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.toString()));
    }
  }
}
