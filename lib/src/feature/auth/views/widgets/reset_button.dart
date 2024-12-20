// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ResetButton extends StatelessWidget {
  String resetText;
  IconData icon;
  VoidCallback? onTap;
  ResetButton({
    required this.onTap,
    required this.resetText,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryBackgroundColor,
              size: 30,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resetText,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                  ),
                ),
                const Text(
                  'If you have number linked to account',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: const IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
