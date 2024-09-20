import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/otptextfield.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:studio_partner_app/utils/router.dart';

import '../../../../commons/views/providers/otp.dart';

class VerifyOtp extends ConsumerStatefulWidget {
  const VerifyOtp({super.key});

  @override
  ConsumerState<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends ConsumerState<VerifyOtp> {
  @override
  Widget build(BuildContext context) {
    final otp = ref.watch(otpProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify OTP',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify Mobile Number',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter the 4-Digit code sent to you at\n+919797273832',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Center(child: OtpTextField()),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(StudioRoutes.setNewPasswordScreen);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'VERIFY OTP',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Didn\'t receive the code?'),
                TextButton(
                  onPressed: () {},
                  child: const Text('Resend OTP'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
