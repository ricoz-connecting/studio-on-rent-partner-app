import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/feature/membership_payment/controller/membership_controller.dart';
import 'package:studio_partner_app/src/feature/membership_payment/view/widgets/membership_label.dart';
import 'package:studio_partner_app/src/feature/membership_payment/view/widgets/special_offer_card.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/snackbar_service.dart';

class MembershipPayment extends StatefulWidget {
  const MembershipPayment({super.key});

  @override
  MembershipPaymentState createState() => MembershipPaymentState();
}

class MembershipPaymentState extends State<MembershipPayment> {
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h * 0.5,
                child: Stack(
                  children: [
                    const Image(
                      image: AssetImage(ImageAssets.membershipImage),
                    ),
                    Container(
                      height: h * 0.5,
                      margin: EdgeInsets.only(top: h * 0.08),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.transparent,
                            Colors.white,
                          ],
                          stops: [0.25, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    MembershipLabel(
                      label: 'Unlock Full potential',
                    ),
                    MembershipLabel(
                      label: 'Unlimited studio Listing',
                    ),
                    MembershipLabel(
                      label: 'Commission free Booking',
                    ),
                    MembershipLabel(
                      label: 'Open for 10000+ Indian users',
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.03),
              SpecialOfferWidget(
                screenWidth: w,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        final razorpayController = ref.watch(razorpayControllerProvider);

        return SizedBox(
          height: h * 0.08,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Consumer(builder: (context, ref, child) {
              return ReusableButton(
                radius: 10,
                label: isProcessing ? "Processing..." : "Unlock Now",
                onPressed: () async {
                  setState(() => isProcessing = true);
                  Map<String, dynamic> orderDetails = {
                    "amount": 999,
                  };
                  Map<String, dynamic> orderData = orderDetails;
                  try {
                    await razorpayController.createAndProcessOrder(
                        context, orderData, ref);
                  } catch (e) {
                    SnackBarService.showSnackBar(
                      context: context,
                      message: 'Error Found Try Again',
                      backgroundColor: Colors.red,
                    );
                  } finally {
                    setState(() => isProcessing = false);
                  }
                },
              );
            }),
          ),
        );
      }),
    );
  }
}
