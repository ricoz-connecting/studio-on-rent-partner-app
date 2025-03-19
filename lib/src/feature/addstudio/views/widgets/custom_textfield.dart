import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

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
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        suffixLabel!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                )
              : null,
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: Colors.grey,
                  size: 18,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          filled: true,
          fillColor: const Color(0xFFF4F6F9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.primaryBackgroundColor,
              width: 1,
            ),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
