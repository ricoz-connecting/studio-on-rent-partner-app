
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  const CustomContainer({
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
