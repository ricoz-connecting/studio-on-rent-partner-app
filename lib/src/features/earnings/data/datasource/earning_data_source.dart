import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:studio_partner_app/src/commons/exceptions/api_exception.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';
import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/features/earnings/domain/entity/payment_entity.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';
import 'package:http/http.dart' as http;

abstract interface class EarningDataSource {
  FutureEitherFailure<Earnings> getEarnings(String agentId);
  FutureEitherFailure<List<ReviewModel>> getReviews(String agentId);
}

class EarningDataSourceImpl implements EarningDataSource {
  @override
  FutureEitherFailure<Earnings> getEarnings(String agentId) async {
    try {
      final response = await http.get(Uri.parse(
          "${AppUrls.baseUrl}${AppUrls.earningRequestEndPoint}/$agentId"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data.toString());
        return Right(Earnings.empty());
      } else {
        throw ApiException();
      }
    } catch (e) {
      print(e);
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<ReviewModel>> getReviews(String agentId) {
    // TODO: implement getReviews
    throw UnimplementedError();
  }
}
