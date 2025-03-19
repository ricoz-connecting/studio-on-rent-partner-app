import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class CustomRentSellToggle extends StatelessWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final String rentLabel;
  final String sellLabel;

  const CustomRentSellToggle({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.rentLabel = 'Rent',
    this.sellLabel = 'Sell',
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.size(
      current: initialValue,
      values: const [false, true],
      iconOpacity: 1.2,
      indicatorSize: const Size.fromWidth(180),
      customIconBuilder: (context, local, global) => Text(
        local.value ? rentLabel : sellLabel,
        style: GoogleFonts.poppins(
          color: Color.lerp(Colors.black54, Colors.white, local.animationValue),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      borderWidth: 0.3,
      iconAnimationType: AnimationType.onHover,
      style: ToggleStyle(
        indicatorColor: AppColors.primaryBackgroundColor,
        backgroundColor: const Color.fromRGBO(244, 246, 249, 0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      selectedIconScale: 1.2,
      onChanged: onChanged,
    );
  }
}
