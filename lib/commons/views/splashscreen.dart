import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/controllers/init_controller.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/chat/sockets/chat_socket.dart';
import 'package:studio_partner_app/src/feature/chat_screen/controller/chat_user_id.dart';
import 'package:studio_partner_app/src/res/colors.dart';
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
      mounted
          ? ref
              .read(initControllerProvider)
              .initUserAndToken(context)
              .then((value) {
              final token = ref.read(authTokenProvider);
              final user = ref.read(currentUserProvider);
              if (token == null || user == null) {
                if (!mounted) return;
                context.go(StudioRoutes.onboardingScreen);
              } else {
                if (!mounted) {
                  return;
                } else {
                  final chatUserId = ref.watch(chatUserDocIdProvider);
                  if (chatUserId == null) {
                    ref
                        .read(chatUserControllerProvider.notifier)
                        .updateChatUser(
                          avatar: user.avatar ?? '',
                          email: user.email ?? '',
                          name: user.name ?? '',
                          phone: user.phone ?? '',
                          context: context,
                        );
                  }
                  mounted ? context.go(StudioRoutes.bottomNavBar) : null;
                }
              }
            })
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appbarColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.appbarColor,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.appbarColor,
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
