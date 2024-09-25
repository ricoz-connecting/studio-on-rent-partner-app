import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/core/api.dart';
import 'package:studio_partner_app/src/res/endpoints.dart';

class OrderRepository {
  final API _networkRepo;
  OrderRepository(this._networkRepo);

  Future<dynamic> createOrder(Map<String, dynamic> orderData) async {
    try {
      var result = await _networkRepo.postRequest(
        url: Endpoints.createMembershipPayment,
        body: orderData,
      );
      return result.fold(
        (failure) {
          throw Exception('Failed to create order: ${failure.message}');
        },
        (response) {
          if (response.statusCode == 200 || response.statusCode == 201) {
            return json.decode(response.body);
          } else {
            throw Exception('Failed to create order');
          }
        },
      );
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<dynamic> verifyPayment(Map<String, dynamic> paymentData) async {
    try {
      var result = await _networkRepo.postRequest(
        url: Endpoints.verifyMembershipPayment,
        body: paymentData,
      );
      return result.fold(
        (failure) {
          throw Exception('Failed to verify payment: ${failure.message}');
        },
        (response) {
          if (response.statusCode == 200) {
            return json.decode(response.body);
          } else {
            throw Exception('Failed to verify payment');
          }
        },
      );
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<dynamic> paymentFailed(Map<String, dynamic> paymentData) async {
    try {
      var result = await _networkRepo.postRequest(
        url: Endpoints.paymentFailed,
        body: paymentData,
      );
      return result.fold(
        (failure) {
          throw Exception('Failed to log payment failure: ${failure.message}');
        },
        (response) {
          if (response.statusCode == 200) {
            return json.decode(response.body);
          } else {
            throw Exception('Failed to log payment failure');
          }
        },
      );
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}

// Provider to inject OrderRepository
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final networkRepo = ref.watch(apiProvider);
  return OrderRepository(networkRepo);
});
