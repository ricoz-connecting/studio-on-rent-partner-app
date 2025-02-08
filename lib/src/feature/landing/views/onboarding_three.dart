// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
// import 'package:studio_partner_app/src/res/assets.dart';
// import 'package:studio_partner_app/src/res/colors.dart';
// import 'package:studio_partner_app/utils/router.dart';

// class OnboardingThree extends StatelessWidget {
//   const OnboardingThree({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Image(
//             image: AssetImage(ImageAssets.onboardingThree),
//           ),
//           const SizedBox(height: 20),
//           Text.rich(
//             textAlign: TextAlign.center,
//             TextSpan(
//               text: 'Discover ',
//               style: GoogleFonts.inter(
//                 fontSize: 24,
//                 color: AppColors.primaryBackgroundColor,
//                 fontWeight: FontWeight.bold,
//               ),
//               children: [
//                 TextSpan(
//                   text: 'and Find Your',
//                   style: GoogleFonts.inter(
//                     fontSize: 24,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextSpan(
//                   text: ' Perfect Studio',
//                   style: GoogleFonts.inter(
//                     fontSize: 24,
//                     color: AppColors.primaryBackgroundColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             textAlign: TextAlign.center,
//             '''App to search and discover the most
// suitable place for you to stay ''',
//             style: GoogleFonts.inter(
//               color: Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 20),
//           ReusableButton(
//             label: 'Let’s Get Started',
//             onPressed: () {
//               GoRouter.of(context).replace(StudioRoutes.landingScreen);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageAssets.onboardingThree,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.4,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text.rich(
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
                  ),
                  const SizedBox(height: 5),
                  Text(
                    textAlign: TextAlign.center,
                    '''App to search and discover the most 
suitable place for you to stay''',
                    style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ReusableButton(
                      label: 'Let’s Get Started',
                      onPressed: () {
                        GoRouter.of(context)
                            .replace(StudioRoutes.landingScreen);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
