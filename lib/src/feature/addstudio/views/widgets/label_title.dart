import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLabelTitle extends StatelessWidget {
  const CustomLabelTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
