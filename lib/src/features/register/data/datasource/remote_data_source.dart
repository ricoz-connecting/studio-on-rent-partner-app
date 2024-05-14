import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:studio_partner_app/src/commons/exceptions/api_exception.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';
import 'package:studio_partner_app/src/commons/params/register_params.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';
import 'package:http/http.dart' as http;

abstract interface class RemoteDataSource {
  FutureEitherFailure<String> regiseterSuccess(RegisterParams params);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  FutureEitherFailure<String> regiseterSuccess(RegisterParams params) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse("${AppUrls.baseUrl}${AppUrls.registerEndpoint}"));
      request.files.addAll([
        http.MultipartFile.fromBytes("photoUrl", params.photoUrl,
            filename: "photoUrl"),
        http.MultipartFile.fromBytes("documentFront", params.documentFront,
            filename: "front"),
        http.MultipartFile.fromBytes("documentBack", params.documentBack,
            filename: "back"),
      ]);
      request.files.addAll(params.media
          .map((e) => http.MultipartFile.fromBytes(const Uuid().v4(), e))
          .toList());
      request.fields["fields"] = jsonEncode(params.toMap());

      final response = await request.send();
      log(response.toString());
      if (response.statusCode == 200) {
        final body = jsonDecode(await response.stream.bytesToString());
        final String isVerified = body['isVerified'];
        final String agentId = body['agentId'];
       await Hive.box('USER').put('agentId', agentId);
        return Right(isVerified);
      } else {
        throw ApiException();
      }
    } on ApiException catch (e) {
      log(e.message);
      return Left(ApiFailure(messages: e.message));
    } catch (e) {
      log(e.toString());
      return Left(ApiFailure(messages: e.toString()));
    }
  }
}
