import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:studio_partner_app/src/feature/membership_payment/repo/membership_repo.dart';

class RazorpayController {
  final OrderRepository repository;
  late Razorpay _razorpay;
  String? _currentOrderId;
  String? _partnerDocId;
  BuildContext? _context;

  RazorpayController({required this.repository}) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> createAndProcessOrder(
      BuildContext context, Map<String, dynamic> orderData) async {
    try {
      _context = context;
      final orderResponse = await repository.createOrder(orderData);

      if (orderResponse != null) {
        print("Order Response: $orderResponse");

        // Fixing how the response is accessed
        _currentOrderId = orderResponse["order"]["id"];
        _partnerDocId = orderData['partnerDocId'];

        Map<String, dynamic> updatedOrderResponse = {
          ...orderResponse,
          'partnerDocId': orderData['partnerDocId'],
        };

        _openRazorpayCheckout(context, updatedOrderResponse);
      }
    } catch (e) {
      print("Error creating and processing order: $e");
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
      print("Opening Razorpay with options: $options");
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay checkout: $e");
    }

    print(
        "Order id before push to profile screen: ${orderResponse["data"]["_id"]}");
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      print("Payment successful: ${response}");
      print("Order ID: ${response.orderId}");
      print("Payment ID: ${response.paymentId}");
      print("Signature: ${response.signature}");
      final verificationResponse = await repository.verifyPayment({
        "partnerDocId": _partnerDocId,
        "razorpay_order_id": response.orderId,
        "razorpay_payment_id": response.paymentId,
        "razorpay_signature": response.signature,
      });
      if (verificationResponse["success"] == true) {
        print("Payment verified successfully");
        // _context!.push(ProfileScreen.routePath);
      } else {
        print("Payment verification failed");
      }
    } catch (e) {
      print("Error verifying payment: $e");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print("Payment failed: ${response.message}");
    try {
      final failureResponse = await repository.paymentFailed({
        "partnerDocId": _partnerDocId,
        "razorpay_order_id": _currentOrderId,
        "error_code": response.code,
        "error_message": response.message,
        "error_description": response.error
      });
      if (failureResponse["success"] == true) {
        print("Payment failure logged successfully");
      } else {
        print("Payment failure logging failed");
      }
    } catch (e) {
      print("Error logging payment failure: $e");
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External wallet selected: ${response.walletName}");
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
