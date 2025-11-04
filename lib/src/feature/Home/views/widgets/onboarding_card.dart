import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/utils/router.dart';

class OnboardingCard extends StatelessWidget {
  final double width;
  const OnboardingCard({required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0XFFFFF7E4),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: const Color(0XFFFFE49F),
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Onboarding Incomplete',
                style: GoogleFonts.inter(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Your onboarding is incomplete. Please complete it to continue.',
                style: GoogleFonts.inter(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push(StudioRoutes.kycPage);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: const Color(0xFFFCA505),
                ),
                child: const Text(
                  'Go to Onboarding',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
