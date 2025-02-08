import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialOfferWidget extends StatelessWidget {
  final double screenWidth;
  const SpecialOfferWidget({required this.screenWidth, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unlock Your Special Offer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    '₹999',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '₹2599',
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                'for a Lifetime Listing',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(screenWidth * 0.7, -0),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFF18A2C),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Special Offer',
              style: GoogleFonts.openSans(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
