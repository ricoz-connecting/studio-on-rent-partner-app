import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ChipSelection extends StatefulWidget {
  const ChipSelection({super.key});

  @override
  State<ChipSelection> createState() => _ChipSelectionState();
}

class _ChipSelectionState extends State<ChipSelection> {
  String _selectedCategory = 'Recording';

  final List<String> categories = [
    'Recording',
    'Photography',
    'Misc.',
    'Luxury',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 2,
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;
          return ChoiceChip(
            showCheckmark: false,
            label: Text(
              category,
              style: TextStyle(
                color:
                    isSelected ? AppColors.primaryBackgroundColor : Colors.grey,
              ),
            ),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                _selectedCategory = category;
              });
            },
            selectedColor: Colors.transparent,
            side: BorderSide(
              color:
                  isSelected ? AppColors.primaryBackgroundColor : Colors.grey,
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
