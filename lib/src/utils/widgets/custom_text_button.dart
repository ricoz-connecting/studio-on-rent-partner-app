import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/utils/widgets/custom_extension_methods.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      this.bgColor,
      required this.text,
      this.textColor,
      this.borderRadius=20,
      required this.ontap});

  final Color? bgColor;
  final String text;
  final Color? textColor;
  final VoidCallback ontap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      // width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius), color: colorScheme.primary),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: colorScheme.onPrimary),
        ),
      ),
    ).onTap(ontap);
  }
}
