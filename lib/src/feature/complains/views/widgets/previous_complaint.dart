import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviousCompaintWidgte extends StatelessWidget {
  final void Function()? onTap;
  const PreviousCompaintWidgte({
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              'View Previous complaints',
              style: GoogleFonts.lato(),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
