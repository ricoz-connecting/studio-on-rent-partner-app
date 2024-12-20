import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/feature/membership_payment/controller/membership_controller.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class MembershipPayment extends StatefulWidget {
  const MembershipPayment({super.key});

  @override
  MembershipPaymentState createState() => MembershipPaymentState();
}

class MembershipPaymentState extends State<MembershipPayment> {
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
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.transparent,
                            Colors.white,
                          ],
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
                    Positioned(
                      bottom: 20,
                      left: w * 0.2,
                      child: Image.asset(
                        ImageAssets.appLogo,
                        scale: 4,
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
              SizedBox(height: h * 0.05),
              SpecialOfferWidget(
                screenWidth: w,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        final razorpayController = ref.watch(razorpayControllerProvider);
        // final user = ref.read(currentUserProvider);
        return SizedBox(
          height: h * 0.1,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ReusableButton(
              radius: 8,
              label: 'Unlock Now',
              onPressed: () {
                // Creating a map to hold the order details
                Map<String, dynamic> orderDetails = {
                  "amount": 999,
                  "partnerDocId": "66d5c40a25221c05fc90e476",
                };
                Map<String, dynamic> orderData = orderDetails;
                razorpayController.createAndProcessOrder(context, orderData);
              },
            ),
          ),
        );
      }),
    );
  }
}

class MembershipLabel extends StatelessWidget {
  final String label;
  const MembershipLabel({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle),
          const SizedBox(width: 10),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialOfferWidget extends StatelessWidget {
  final double screenWidth;
  const SpecialOfferWidget({required this.screenWidth, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F9),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unlock Your Special Offer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '₹999',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '₹2599',
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'for a Lifetime Listing',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(screenWidth * 0.75, -10),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFF18A2C),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Special Offer',
              style: GoogleFonts.openSans(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
