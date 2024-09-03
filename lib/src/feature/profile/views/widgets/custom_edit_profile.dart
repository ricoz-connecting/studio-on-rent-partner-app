import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomEditProfile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;
  const CustomEditProfile({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: ListTile(
          leading: Icon(
            icon,
          ),
          title: Text(
            label,
            style: GoogleFonts.lato(),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ),
    );
  }
}
