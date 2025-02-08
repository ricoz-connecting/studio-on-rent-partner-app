import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoSection extends StatelessWidget {
  final String businessName;
  final String address;
  final String pincode;
  final String city;
  const InfoSection({
    required this.city,
    required this.pincode,
    required this.businessName,
    required this.address,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business Name',
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            businessName,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Address',
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            {
              address,
              city,
              pincode,
            }.join(', '),
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
