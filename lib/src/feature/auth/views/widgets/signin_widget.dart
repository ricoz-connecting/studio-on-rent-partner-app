import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninWidget extends StatelessWidget {
  final void Function() onTap;
  final IconData? icon;
  final String? iconImage;
  final String label;
  const SigninWidget({
    required this.label,
    this.icon,
    this.iconImage,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              icon == null
                  ? Image(
                      image: AssetImage(iconImage!),
                      height: 20,
                      width: 20,
                    )
                  : Icon(icon),
              const SizedBox(width: 20),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
