import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/membership_payment/controller/membership_controller.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class MembershipPayment extends StatefulWidget {
  const MembershipPayment({super.key});
  static const routePath = "/membership";

  @override
  MembershipPaymentState createState() => MembershipPaymentState();
}

class MembershipPaymentState extends State<MembershipPayment> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Membership"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        final razorpayController = ref.watch(razorpayControllerProvider);
        // final user = ref.read(currentUserProvider);
        return SizedBox(
          height: h * 0.1,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                // Creating a map to hold the order details
                Map<String, dynamic> orderDetails = {
                  "amount": 999,
                  "partnerDocId": "66d5c40a25221c05fc90e476",
                };
                Map<String, dynamic> orderData = orderDetails;

                razorpayController.createAndProcessOrder(context, orderData);
              },
              child: const Text("Proceed To Pay"),
            ),
          ),
        );
      }),
    );
  }
}
