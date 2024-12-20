// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:studio_partner_app/src/res/assets.dart';
// import 'package:studio_partner_app/src/res/colors.dart';
// import 'package:studio_partner_app/utils/router.dart';

// class LandingScreen extends StatelessWidget {
//   const LandingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.6,
//               child: Stack(
//                 children: [
//                   Center(
//                     child: Image(
//                       width: MediaQuery.of(context).size.width,
//                       fit: BoxFit.cover,
//                       image: const AssetImage(ImageAssets.studiohome),
//                     ),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: <Color>[
//                           Colors.transparent,
//                           Colors.white,
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Text(
//               textAlign: TextAlign.center,
//               'Near by Studio on your Fingertips',
//               style:
//                   GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               textAlign: TextAlign.center,
//               'Are you ready to uproot and start over in a new area? Placoo will help you on your journey!',
//               style: GoogleFonts.inter(fontWeight: FontWeight.w300),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.9,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 color: AppColors.primaryBackgroundColor,
//               ),
//               child: TextButton(
//                 onPressed: () {
//                   GoRouter.of(context).push(StudioRoutes.loginViaEmailScreen);
//                 },
//                 child: Text(
//                   'Log in',
//                   style: GoogleFonts.inter(
//                     color: Colors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.9,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 border: Border.all(color: Colors.grey.shade400),
//                 color: AppColors.white,
//               ),
//               child: TextButton(
//                 onPressed: () {
//                   GoRouter.of(context).push(StudioRoutes.signUpViaEmailScreen);
//                 },
//                 child: Text(
//                   'Sign up',
//                   style: GoogleFonts.inter(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.5,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        ImageAssets.studiohome,
                        width: screenWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Replacing Spacer with SizedBox
              Text(
                'Near by Studio on your Fingertips',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Are you ready to uproot and start over in a new area? Placoo will help you on your journey!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(height: 20),
              _buildButton(
                context,
                'Log in',
                AppColors.primaryBackgroundColor,
                Colors.white,
                () {
                  GoRouter.of(context).push(StudioRoutes.loginViaEmailScreen);
                },
              ),
              const SizedBox(height: 10),
              _buildButton(
                context,
                'Sign up',
                AppColors.white,
                Colors.black,
                () {
                  GoRouter.of(context).push(StudioRoutes.signUpViaEmailScreen);
                },
                borderColor: Colors.grey.shade400,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed, {
    Color? borderColor,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
