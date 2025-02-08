import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:studio_partner_app/commons/controllers/status_controller.dart';
import 'package:studio_partner_app/src/feature/membership_payment/repo/membership_repo.dart';
import 'package:studio_partner_app/utils/config.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

class RazorpayController {
  final OrderRepository repository;
  late Razorpay _razorpay;
  WidgetRef? _ref;
  String? _currentOrderId;
  BuildContext? _context;
  String? _partnerDocId;
  String? _membershipDocId;

  RazorpayController({required this.repository}) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> createAndProcessOrder(BuildContext context,
      Map<String, dynamic> orderData, WidgetRef ref) async {
    _context = context;
    _ref = ref;
    try {
      final orderResponse = await repository.createOrder(orderData);

      if (orderResponse != null) {
        log("Order Response: $orderResponse");

        _currentOrderId = orderResponse["order"]["id"];
        _membershipDocId = orderResponse['data']['_id'];

        Map<String, dynamic> updatedOrderResponse = {
          ...orderResponse,
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
      'theme': {'color': '#6D52EF'}
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
      if (AppConfig.logHttp) {
        log("Payment successful: $response");
        log("Order ID: ${response.orderId}");
        log("Payment ID: ${response.paymentId}");
        log("Signature: ${response.signature}");
      }

      final verificationResponse = await repository.verifyPayment({
        "partnerMembershipDocId": _membershipDocId,
        "razorpay_order_id": response.orderId,
        "razorpay_payment_id": response.paymentId,
        "razorpay_signature": response.signature,
      });
      if (verificationResponse["success"] == true) {
        log("Payment verified successfully");
        final status = _ref
            ?.read(statusControllerProvider.notifier)
            .getStatus(context: _context!);

        GoRouter.of(_context!).pop();
      } else {
        if (AppConfig.logHttp) {
          log("Payment verification failed");
        }
        SnackBarService.showSnackBar(
          context: _context!,
          message: 'Payment Verifications Failed',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      if (AppConfig.logHttp) {
        log("Error verifying payment: $e");
      }
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    if (AppConfig.logHttp) {
      log("Payment failed: ${response.message}");
    }

    try {
      final failureResponse = await repository.paymentFailed({
        "partnerMembershipDocId": _membershipDocId,
      });
      if (failureResponse["success"] == true) {
        final status = _ref
            ?.read(statusControllerProvider.notifier)
            .getStatus(context: _context!);
        SnackBarService.showSnackBar(
          context: _context!,
          message: 'Payment Failed',
          backgroundColor: Colors.red,
        );
      } else {
        if (AppConfig.logHttp) {
          log("Payment failure logging failed");
        }
      }
    } catch (e) {
      if (AppConfig.logHttp) {
        log("Error logging payment failure: $e");
      }
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
