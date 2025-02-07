import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountTextWidget extends StatelessWidget {
  final String label, amount;
  const AmountTextWidget({
    super.key,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(
              0xFF444444,
            ),
          ),
        ),
        const Spacer(),
        Text(
          amount,
          style: GoogleFonts.inter(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
