import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final String? suffixLabel;
  final String? hintText;
  final TextInputType? keyboardType;
  const CustomTextField({
    this.suffixLabel,
    this.icon,
    this.keyboardType,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        suffixIcon: suffixLabel != null ? Text(suffixLabel!) : null,
        prefixIcon: icon != null ? Icon(icon) : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 14,
        ),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
      ),
    );
  }
}
