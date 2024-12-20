import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/forgotpassword/controller/recover_password_controller.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/textfield.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ResetPassSms extends StatefulWidget {
  const ResetPassSms({super.key});

  @override
  State<ResetPassSms> createState() => _ResetPassSmsState();
}

class _ResetPassSmsState extends State<ResetPassSms> {
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Mobile Number',
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Enter you mobile number to receive an OTP',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),

            ReusableAuthTextField(
              controller: phoneController,
              hintText: 'Enter Phone Number',
              obscureText: false,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('+91'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required.';
                } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                  return 'Enter a valid 10-digit phone number.';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Consumer(builder: (context, ref, child) {
              return GestureDetector(
                onTap: () {
                  ref
                      .read(recoverControllerProvider.notifier)
                      .sendOTPForRecover(
                        phone: phoneController.text,
                        context: context,
                      );
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
                      'SEND OTP',
                      style: GoogleFonts.inter(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     width: double.infinity,
            //     padding: const EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //       color: AppColors.primaryBackgroundColor,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Center(
            //       child: Text(
            //         'SEND OTP',
            //         style: GoogleFonts.inter(
            //             color: Colors.white, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
