import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final String? suffixLabel;
  final int? maxLines;
  final String? hintText;
  final double? height;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool disableTextField;
  const CustomTextField({
    required this.disableTextField,
    this.controller,
    this.onChanged,
    this.height,
    this.maxLines,
    this.suffixLabel,
    this.icon,
    this.keyboardType,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height ?? 50,
      child: TextField(
        enabled: !disableTextField,
        controller: controller,
        maxLines: maxLines ?? 1,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          suffixIcon: suffixLabel != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(suffixLabel!),
                  ],
                )
              : null,
          prefixIcon: icon != null ? Icon(icon) : null,
          contentPadding: const EdgeInsets.all(
            14,
          ),
          filled: true,
          fillColor: const Color(0xFFF4F6F9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
