import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function()? onTap;
  const SettingsCard({
    required this.onTap,
    required this.label,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: label == 'Logout'
              ? const Color(0xFFFEF5F5)
              : const Color(0xFFF2F2F3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: label == 'Logout' ? const Color(0xFFDF0000) : Colors.black,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.lato(
                  fontSize: 18,
                  color: label == 'Logout'
                      ? const Color(0xFFDF0000)
                      : Colors.black),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
