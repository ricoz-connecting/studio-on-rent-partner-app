import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class CustomFAB extends StatelessWidget {
  final void Function() onPressed;
  const CustomFAB({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryBackgroundColor,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
