import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/controllers/checkauth.dart';
import 'package:studio_partner_app/commons/repo/get_image_url.dart';
import 'package:studio_partner_app/commons/views/providers/image_upload_url.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/src/res/strings.dart';
import 'package:studio_partner_app/utils/router.dart';

class Splashscreen extends ConsumerStatefulWidget {
  const Splashscreen({super.key});

  @override
  ConsumerState<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends ConsumerState<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      String token = await Checkauth.checkAuth(ref);
      Map<String, dynamic> url = await GetImageUrl.getUploadUrl();
      ref.read(imageUploadUrl.notifier).setImageUploadUrl(url['uploadUrl']);
      ref.read(keyProvider.notifier).setKey(url['key']);
      if (token != '') {
        GoRouter.of(context).replace(StudioRoutes.bottomNavBar);
      } else {
        GoRouter.of(context).replace(StudioRoutes.onboardingScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.splashScreenBackgroundColor,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: <Color>[Color(0xFFBCB1F0), Color(0xFF6F54EF)],
                    //   stops: <double>[0, 1],
                    // ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'book my',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          color: Colors.yellow,
                          child: Text(
                            'studio',
                            style: GoogleFonts.inter(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Discover Your Perfect Studio Space!',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
