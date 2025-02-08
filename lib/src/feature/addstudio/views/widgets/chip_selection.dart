import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ChipSelection extends StatelessWidget {
  final List<String> categories;
  final ValueChanged<String> onCategorySelected;
  final String? selectedCategory;

  const ChipSelection({
    super.key,
    this.selectedCategory,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 8,
        runSpacing: 8,
        children: categories.map((category) {
          return ChoiceChip(
            showCheckmark: false,
            label: Text(
              category,
              style: TextStyle(
                fontSize: 14,
                color: selectedCategory == category
                    ? AppColors.primaryBackgroundColor
                    : Colors.black,
              ),
            ),
            selected: selectedCategory == category,
            onSelected: (selected) => onCategorySelected(category),
            selectedColor: AppColors.primaryBackgroundColor.withOpacity(0.2),
            side: BorderSide(
              color: selectedCategory == category
                  ? AppColors.primaryBackgroundColor
                  : Colors.grey,
              width: 1.5,
            ),
            shape: const StadiumBorder(),
            backgroundColor: Colors.white,
          );
        }).toList(),
      ),
    );
  }
}
