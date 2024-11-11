import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ChipSelection extends StatelessWidget {
  final ValueNotifier<String> _selectedCategory =
      ValueNotifier<String>('Recording');
  final List<String> categories = [
    'Recording',
    'Photography',
    'Misc.',
    'Luxury',
  ];
  final ValueChanged<String> onCategorySelected;

  ChipSelection({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder<String>(
        valueListenable: _selectedCategory,
        builder: (context, selectedCategory, child) {
          return Wrap(
            spacing: 2,
            children: categories.map((category) {
              final isSelected = selectedCategory == category;
              return ChoiceChip(
                showCheckmark: false,
                label: Text(
                  category,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.primaryBackgroundColor
                        : Colors.grey,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  _selectedCategory.value = category;
                  onCategorySelected(
                      category); // Notify parent of the selection
                },
                selectedColor: Colors.transparent,
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primaryBackgroundColor
                      : Colors.grey,
                  width: 1.5,
                ),
                shape: const StadiumBorder(),
                backgroundColor: Colors.transparent,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
