import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class FacilitiesChip extends StatelessWidget {
  final String? label;
  final bool isSelected;
  final void Function() onTap;

  const FacilitiesChip({
    required this.isSelected,
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
          borderRadius: BorderRadius.circular(50),
        ),
        color: WidgetStatePropertyAll(
          isSelected
              ? AppColors.primaryBackgroundColor
              : const Color(0xFFF4F6F9),
        ),
        side: BorderSide.none,
        label: Text(label!,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
        backgroundColor: const Color(0xFFF4F6F9),
      ),
    );
  }
}
