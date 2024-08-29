import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

Widget buildCustomCheckbox(
    String label, bool value, ValueChanged<bool?> onChanged, bool inWrap) {
  return GestureDetector(
    onTap: () {
      onChanged(!value);
    },
    child: Container(
      width: inWrap ? null : double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            value ? Icons.check_box : Icons.check_box_outline_blank,
            color: value ? AppColors.primaryBackgroundColor : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    ),
  );
}
