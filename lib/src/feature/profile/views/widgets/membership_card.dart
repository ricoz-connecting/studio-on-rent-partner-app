import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/utils/router.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.02,
      ),
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                ImageAssets.diamond,
                height: 50,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upgrade To Premium @ ₹999',
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Enjoy Ad Free Experience including',
                    style: GoogleFonts.openSans(
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 10,
            physics: NeverScrollableScrollPhysics(),
            children: const [
              PremiumFeatureText(label: 'Unlock Full potential'),
              PremiumFeatureText(label: 'Commission-free Booking'),
              PremiumFeatureText(label: 'Unlimited Studio Listing'),
              PremiumFeatureText(label: 'Open for 1000+ Indian Users'),
            ],
          ),
          // const Row(
          //   children: [
          //     PremiumFeatureText(
          //       label: 'Unlock Full potential',
          //     ),
          //     SizedBox(width: 5),
          //     PremiumFeatureText(
          //       label: 'Commsission free Booking',
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 5),
          // const Row(
          //   children: [
          //     PremiumFeatureText(
          //       label: 'Unlimited Studio Listing',
          //     ),
          //     SizedBox(width: 5),
          //     PremiumFeatureText(
          //       label: 'Open for 1000+ Indian Users',
          //     ),
          //   ],
          // ),
          const SizedBox(height: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              backgroundColor: const Color(0xFFFCA505),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              GoRouter.of(context).push(StudioRoutes.memmbershipPayment);
            },
            child: Text(
              'Get it now',
              style: GoogleFonts.openSans(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumFeatureText extends StatelessWidget {
  final String label;
  const PremiumFeatureText({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.black,
          size: 16,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
          ),
        )
      ],
    );
  }
}
