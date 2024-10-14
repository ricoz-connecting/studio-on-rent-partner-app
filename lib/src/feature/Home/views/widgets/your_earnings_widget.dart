import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class YourEarningsWidget extends StatelessWidget {
  final String label;
  final String earningLabel;
  final double? width;
  const YourEarningsWidget({
    required this.label,
    required this.earningLabel,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: const Border(
          left: BorderSide(
            color: AppColors.primaryBackgroundColor,
            width: 5,
          ),
        ),
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            earningLabel,
            style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF525252)),
          ),
          Text(
            label,
            style: GoogleFonts.lato(
              color: const Color(0xFF5F5F5F),
            ),
          ),
        ],
      ),
    );
  }
}
