import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/assets.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ResetDialog {
  static Future resetDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImageAssets.iconCheckMark),
                const SizedBox(height: 20),
                Text(
                  'Done',
                  style: GoogleFonts.roboto(
                    color: AppColors.primaryBackgroundColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text.rich(
                  TextSpan(
                    text:
                        'We have successfully sent you the reset password link. Kindly check your email.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: 'Having Trouble?',
                        style: TextStyle(
                          color: AppColors.primaryBackgroundColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBackgroundColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'DONE',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
