import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:studio_partner_app/src/core/themes/theme.dart';
import 'package:studio_partner_app/src/features/auth/presentation/pages/sign_up_page.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const routePath = "/splash";

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      // context.go(HomeView.routePath);
      context.go(SignUpPage.routePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorAssets.white,
        body: const RiveAnimation.asset(
          AnimationAssets.splashAnimation,
          fit: BoxFit.cover,
          animations: [],
        ));
  }
}
