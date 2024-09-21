import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(ImageAssets.onboardingOne),
          ),
          const SizedBox(height: 20),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'Discover Studios ',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'Using The Map',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: AppColors.primaryBackgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            'Browse through a variety of studio categories tailored to your creative needs.',
            style: GoogleFonts.inter(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
