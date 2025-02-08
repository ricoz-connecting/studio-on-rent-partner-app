import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomEditProfile extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Function onTap;
  final bool requireLeadingIcon;
  final Color? color;
  const CustomEditProfile({
    this.requireLeadingIcon = true,
    required this.label,
    this.color,
    this.icon,
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
        decoration: BoxDecoration(
          color: const Color(0xFFF4F6F9),
          borderRadius: BorderRadius.circular(14),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          leading: Icon(
            color: color ?? Colors.black,
            icon,
          ),
          title: Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 14,
              color: color ?? Colors.black,
            ),
          ),
          trailing: color == null
              ? requireLeadingIcon == true
                  ? const Icon(
                      Icons.arrow_forward_ios,
                    )
                  : null
              : null,
        ),
      ),
    );
  }
}
