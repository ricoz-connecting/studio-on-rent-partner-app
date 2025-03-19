import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class FacilitiesChip extends StatelessWidget {
  final String? label;
  final bool isSelected;
  final void Function() onTap;

  const FacilitiesChip({
    this.isSelected = false,
    required this.onTap,
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: WidgetStatePropertyAll(
          isSelected
              ? AppColors.primaryBackgroundColor
              : const Color(0xFFF2F2F3),
        ),
        side: BorderSide.none,
        label: Text(
          label!,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : const Color(0XFF7D7F88),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF2F2F3),
      ),
    );
  }
}
