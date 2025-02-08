import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class CustomExpansionTile extends StatelessWidget {
  final String title;
  final String content;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      iconColor: AppColors.primaryBackgroundColor,
      collapsedIconColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 12),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            content,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}
