import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:studio_partner_app/src/feature/membership_payment/repo/membership_repo.dart';

class RazorpayController {
  final OrderRepository repository;
  late Razorpay _razorpay;
  String? _currentOrderId;
  String? _partnerDocId;

  RazorpayController({required this.repository}) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> createAndProcessOrder(
      BuildContext context, Map<String, dynamic> orderData) async {
    try {
      final orderResponse = await repository.createOrder(orderData);

      if (orderResponse != null) {
        log("Order Response: $orderResponse");

        // Fixing how the response is accessed
        _currentOrderId = orderResponse["order"]["id"];
        _partnerDocId = orderData['partnerDocId'];

        Map<String, dynamic> updatedOrderResponse = {
          ...orderResponse,
          'partnerDocId': orderData['partnerDocId'],
        };

        context.mounted
            ? _openRazorpayCheckout(context, updatedOrderResponse)
            : null;
      }
    } catch (e) {
      log("Error creating and processing order: $e");
    }
  }

  void _openRazorpayCheckout(
      BuildContext context, dynamic orderResponse) async {
    var options = {
      'key': 'rzp_test_V4AfRMCT7NCvF9',
      'amount': orderResponse["order"]["amount"] * 100, // In Paisa
      'order_id': orderResponse["order"]["id"],
      'currency': 'INR',
      'name': 'BookMyStudio',
      'description': 'Purchase Description',
      'theme': {'color': '#62B179'}
    };

    try {
      log("Opening Razorpay with options: $options");
      _razorpay.open(options);
    } catch (e) {
      log("Error opening Razorpay checkout: $e");
    }

    log("Order id before push to profile screen: ${orderResponse["data"]["_id"]}");
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      log("Payment successful: $response");
      log("Order ID: ${response.orderId}");
      log("Payment ID: ${response.paymentId}");
      log("Signature: ${response.signature}");
      final verificationResponse = await repository.verifyPayment({
        "partnerDocId": _partnerDocId,
        "razorpay_order_id": response.orderId,
        "razorpay_payment_id": response.paymentId,
        "razorpay_signature": response.signature,
      });
      if (verificationResponse["success"] == true) {
        log("Payment verified successfully");
        // _context!.push(ProfileScreen.routePath);
      } else {
        log("Payment verification failed");
      }
    } catch (e) {
      log("Error verifying payment: $e");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    log("Payment failed: ${response.message}");
    try {
      final failureResponse = await repository.paymentFailed({
        "partnerDocId": _partnerDocId,
        "razorpay_order_id": _currentOrderId,
        "error_code": response.code,
        "error_message": response.message,
        "error_description": response.error
      });
      if (failureResponse["success"] == true) {
        log("Payment failure logged successfully");
      } else {
        log("Payment failure logging failed");
      }
    } catch (e) {
      log("Error logging payment failure: $e");
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External wallet selected: ${response.walletName}");
  }

  void dispose() {
    _razorpay.clear();
  }
}

// Provider to inject RazorpayController
final razorpayControllerProvider = Provider((ref) {
  final orderRepository = ref.watch(orderRepositoryProvider);
  return RazorpayController(repository: orderRepository);
});
