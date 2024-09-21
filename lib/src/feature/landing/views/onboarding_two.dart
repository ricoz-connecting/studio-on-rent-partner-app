import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(ImageAssets.onboardingTwo),
          ),
          const SizedBox(height: 20),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'Arrange Tours ',
              style: GoogleFonts.inter(
                fontSize: 24,
                color: AppColors.primaryBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'to View Studio',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            textAlign: TextAlign.center,
            'Keep track of your booking , stay, organized, & never miss a creative opportunity.',
            style: GoogleFonts.inter(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
