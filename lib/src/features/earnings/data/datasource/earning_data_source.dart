import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';
import 'package:studio_partner_app/src/commons/exceptions/api_exception.dart';
import 'package:studio_partner_app/src/commons/exceptions/failure.dart';
import 'package:studio_partner_app/src/commons/globals/agent_details.dart';
import 'package:studio_partner_app/src/commons/globals/studio_details.dart';
import 'package:studio_partner_app/src/commons/params/bank_params.dart';
import 'package:studio_partner_app/src/core/models/agent_model.dart';
import 'package:studio_partner_app/src/features/earnings/domain/entity/payment_entity.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/schedule_entity.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/src/res/typedefs.dart';
import 'package:http/http.dart' as http;

abstract interface class EarningDataSource {
  FutureEitherFailure<Earnings> getEarnings(String agentId);
  FutureEitherFailure<List<ReviewModel>> getReviews(String agentId);
  FutureEitherFailure<AgentModel> makePayments(PaymentParams params);
}

class EarningDataSourceImpl implements EarningDataSource {
  @override
  FutureEitherFailure<Earnings> getEarnings(String agentId) async {
    try {
      int todaysamount = 0;
      final response = await http.get(Uri.parse(
          "${AppUrls.baseUrl}${AppUrls.earningRequestEndPoint}/$agentId"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        log(data.toString());
        final List<Transactions> orders = data['orders']
            .map<Transactions>((e) => Transactions.fromMap(e))
            .toList();
        final List<Schedules> schedules = data['schedule']
            .map<Schedules>((e) => Schedules.fromMap(e))
            .toList();

        orders.where((e) {
          final todayday = Intl().date("yyyy-MM-dd").format(DateTime.now());

          final dates = Intl().date("yyyy-MM-dd").format(e.created_at);
          return todayday == dates;
        }).map((e) {
          todaysamount += int.parse(e.amount);
        });
        final List<Transactions> payout = data['payouts']
            .map<Transactions>((e) => Transactions.fromMap(e))
            .toList();
        orders.addAll(payout);

        final earnings = Earnings(
            todaysEarning: todaysamount,
            toatalEarning: globalAgentModel!.amount,
            allSchdules: schedules.length,
            rejectedSchedules: schedules.where((schedule) {
              return schedule.status == 'rejected';
            }).length,
            acceptedSchedules: schedules.where((schedule) {
              return schedule.status == 'accepted';
            }).length,
            pendingSchedules: schedules.where((schedule) {
              return schedule.status == 'pending';
            }).length,
            transaction: orders);
        return Right(earnings);
      } else {
        throw ApiException();
      }
    } catch (e) {
      // assert(false, e.toString());
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<List<ReviewModel>> getReviews(String agentId) async {
    // TODO: implement getReviews
    try {
      final response = await http.get(
          Uri.parse("${AppUrls.baseUrl}${AppUrls.reviewEndPoint}/$agentId"));
      if (response.statusCode == 200) {
        log(response.body);
        final body = jsonDecode(response.body);
        final data = (body as List).map((e) => ReviewModel.fromMap(e)).toList();
        return Right(data);
      } else {
        throw ApiException(message: response.body);
      }
    } on ApiException catch (e) {
      print(e.message);
      return Left(ApiFailure(messages: e.toString()));
    }
  }

  @override
  FutureEitherFailure<AgentModel> makePayments(PaymentParams params) async {
    try {
      final response = await http.post(
          Uri.parse(
            "${AppUrls.baseUrl}${AppUrls.withdrawEndPoint}",
          ),
          headers: {'content-type': 'application/json'},
          body: params.toJson());
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        globalAgentModel = AgentModel.fromMap(body);
        return Right(globalAgentModel!);
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
}
