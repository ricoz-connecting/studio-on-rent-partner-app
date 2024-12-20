import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/controllers/auth_controller.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/otptextfield.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import '../../../../commons/views/providers/otp.dart';

class SendOtp extends ConsumerStatefulWidget {
  final String phoneNumber;
  const SendOtp({required this.phoneNumber, super.key});

  @override
  ConsumerState<SendOtp> createState() => _SendOtpState();
}

class _SendOtpState extends ConsumerState<SendOtp> {
  @override
  Widget build(BuildContext context) {
    final otp = ref.watch(otpProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verification Code',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'We have sent the verification code to your mobile number',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              const Center(child: OtpTextField()),
              const SizedBox(height: 50),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryBackgroundColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).verifyOtp(
                          otp: otp,
                          phone: widget.phoneNumber,
                          context: context,
                        );
                    // VerifyOtp(
                    //         context: context,
                    //         phoneNumber: widget.phoneNumber,
                    //         otp: otp)
                    //     .verifyOtp(ref);
                  },
                  child: Text('Confirm',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
