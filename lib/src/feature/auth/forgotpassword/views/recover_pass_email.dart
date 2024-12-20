import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/auth/forgotpassword/controller/recover_password_controller.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class RecoverPassEmail extends StatefulWidget {
  const RecoverPassEmail({super.key});

  @override
  State<RecoverPassEmail> createState() => _RecoverPassEmailState();
}

class _RecoverPassEmailState extends State<RecoverPassEmail> {
  final TextEditingController emailController = TextEditingController();
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset Password',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'Enter your email address to recover your password',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: emailController,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.mail,
                  color: AppColors.primaryBackgroundColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                hintText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            Consumer(builder: (context, ref, child) {
              return GestureDetector(
                onTap: () async {
                  await ref
                      .read(recoverControllerProvider.notifier)
                      .sentResetLinkOnEmail(
                        email: emailController.text,
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
                      'SEND RESET LINK',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
