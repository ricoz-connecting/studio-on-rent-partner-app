import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Studio Service',
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
                '+ ₹6000',
                style: GoogleFonts.lato(
                    color: const Color(0xFF16BF27),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '25/05/2024',
                style: GoogleFonts.lato(
                  color: const Color(0xFF656565),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
