import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(ImageAssets.onboardingThree),
          ),
          const SizedBox(height: 20),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: 'Discover ',
              style: GoogleFonts.inter(
                fontSize: 24,
                color: AppColors.primaryBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'and Find Your',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' Perfect Studio',
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
            '''App to search and discover the most 
suitable place for you to stay ''',
            style: GoogleFonts.inter(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          ReusableButton(
            label: 'Let’s Get Started',
            onPressed: () {
              GoRouter.of(context).replace(StudioRoutes.landingScreen);
            },
          ),
        ],
      ),
    );
  }
}
