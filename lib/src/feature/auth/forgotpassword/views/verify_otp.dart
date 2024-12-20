import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/forgotpassword/controller/recover_password_controller.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class VerifyOtp extends ConsumerStatefulWidget {
  VerifyOtp({super.key, required this.phoneNumber});
  String phoneNumber;

  @override
  ConsumerState<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends ConsumerState<VerifyOtp> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  @override
  void dispose() {
    // Clean up the controllers and focus nodes when the widget is disposed.
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Future<void> loginWithOtp() async {
    String otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length == 6) {
      ref.read(recoverControllerProvider.notifier).verifyOTPForRecovery(
            otp: otp,
            phone: widget.phoneNumber,
            context: context,
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Verify OTP',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify Mobile Number',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Enter the 4-Digit code sent to you at +91 ${widget.phoneNumber}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: _buildOtpBox(index),
                  );
                }),
              ),
            ),
            Consumer(builder: (context, ref, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Didn\'t receive the code?'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Resend OTP'),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Consumer(builder: (context, ref, child) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Setnewpass()));
              loginWithOtp();
            },
            child: Container(
              width: double.infinity,
              height: 50,
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
          );
        }),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.12,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextField(
          controller: _otpControllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.only(bottom: 8.0),
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 5) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}
