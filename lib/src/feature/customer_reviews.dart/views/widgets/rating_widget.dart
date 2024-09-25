import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingWidget extends StatelessWidget {
  final String label;
  const RatingWidget({
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
            '4.5',
            style: GoogleFonts.lato(
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 5),
          const Text(
            '(Based on 345 reviews)',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
