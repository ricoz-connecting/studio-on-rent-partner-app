import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingWidget extends StatelessWidget {
  final String label;
  final double rating;
  final int reviewCount;
  const RatingWidget({
    required this.reviewCount,
    required this.rating,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 18,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Text(
            rating.toString(),
            style: GoogleFonts.lato(
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '(Based on $reviewCount reviews)',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
