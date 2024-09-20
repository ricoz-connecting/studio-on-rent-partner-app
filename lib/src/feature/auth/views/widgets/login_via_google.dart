import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/utils/router.dart';

class LoginViaGoogleOrPhone extends StatelessWidget {
  const LoginViaGoogleOrPhone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LoginCard(
          label: "Login with Google",
          child: Image.asset(
            ImageAssets.googleimage,
            height: 30,
          ),
        ),
        LoginCard(
          onPressed: () {
            GoRouter.of(context).push(StudioRoutes.loginViaPhone);
          },
          label: "Login with Phone",
          child: const Icon(Icons.phone),
        ),
      ],
    );
  }
}

class LoginCard extends StatelessWidget {
  final String? label;
  final Widget? child;
  final void Function()? onPressed;
  const LoginCard({
    this.onPressed,
    this.child,
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: child!),
              const SizedBox(width: 10),
              Text(
                label!,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
