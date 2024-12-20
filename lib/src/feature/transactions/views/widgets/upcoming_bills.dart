import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/assets.dart';

class UpcomingBillsWidget extends StatelessWidget {
  const UpcomingBillsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFF4F6F9),
            child: Image.asset(
              ImageAssets.profile,
            ),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Studio 1',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'ID : 12345',
                style: GoogleFonts.lato(
                  color: const Color(0xFF656565),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Next Billings on',
                style: GoogleFonts.lato(
                  color: const Color(0xFF5D5D5D),
                ),
              ),
              Text(
                '25/05/2024',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: const Color(0xFF1C1C1C),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
