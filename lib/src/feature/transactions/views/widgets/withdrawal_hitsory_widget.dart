import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WithdrawalHitsoryWidget extends StatelessWidget {
  const WithdrawalHitsoryWidget({
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
                'Txn ID : 12345',
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
                '- ₹500',
                style: GoogleFonts.lato(
                    color: Colors.red,
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
