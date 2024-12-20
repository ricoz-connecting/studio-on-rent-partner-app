import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ChipSelection extends StatelessWidget {
  final List<String> categories;
  final ValueChanged<String> onCategorySelected;
  final String? selectedCategory;
  ChipSelection({
    super.key,
    this.selectedCategory,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 2,
        children: categories.map((category) {
          return ChoiceChip(
            showCheckmark: false,
            label: Text(
              category,
              style: TextStyle(
                color: selectedCategory == category
                    ? AppColors.primaryBackgroundColor
                    : Colors.grey,
              ),
            ),
            selected: selectedCategory == category,
            onSelected: (selected) {
              onCategorySelected(category);
            },
            selectedColor: Colors.transparent,
            side: BorderSide(
              color: selectedCategory == category
                  ? AppColors.primaryBackgroundColor
                  : Colors.grey,
              width: 1.5,
            ),
            shape: const StadiumBorder(),
            backgroundColor: Colors.transparent,
          );
        }).toList(),
      ),
    );
  }
}
