import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class CustomActiveCompletedToggle extends StatelessWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final String activeLabel;
  final String completedLabel;

  const CustomActiveCompletedToggle({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.activeLabel = 'Active',
    this.completedLabel = 'Completed',
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.size(
      current: initialValue,
      values: const [false, true],
      iconOpacity: 1.2,
      indicatorSize: const Size.fromWidth(180),
      customIconBuilder: (context, local, global) => Text(
        local.value ? completedLabel : activeLabel,
        style: TextStyle(
          color: Color.lerp(Colors.black26, Colors.black, local.animationValue),
        ),
      ),
      borderWidth: 0,
      iconAnimationType: AnimationType.onHover,
      style: ToggleStyle(
        indicatorColor: Colors.white,
        backgroundColor: const Color.fromRGBO(244, 246, 249, 0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0.00, 0.75),
          ),
        ],
      ),
      selectedIconScale: 1.2,
      onChanged: onChanged,
    );
  }
}
