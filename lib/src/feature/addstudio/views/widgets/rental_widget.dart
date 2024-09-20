import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RentalWidget extends StatelessWidget {
  final String? label;
  const RentalWidget({
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey.shade200),
      width: double.infinity,
      child: Text(
        textAlign: TextAlign.center,
        label!,
        style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
