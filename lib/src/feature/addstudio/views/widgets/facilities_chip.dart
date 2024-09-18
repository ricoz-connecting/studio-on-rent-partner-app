import 'package:flutter/material.dart';

class FacilitiesChip extends StatelessWidget {
  final String? label;
  const FacilitiesChip({
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      side: BorderSide.none,
      label: Text(label!),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
