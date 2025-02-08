import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Contact Us',
        style: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      iconColor: AppColors.primaryBackgroundColor,
      collapsedIconColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      tilePadding: const EdgeInsets.symmetric(horizontal: 12),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ContactOptionButton(
                icon: Icons.mail,
                label: 'Mail Us',
                onPressed: _handleMail,
              ),
              ContactOptionButton(
                icon: Icons.phone,
                label: 'Call Us',
                onPressed: _handleCall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static void _handleMail() {
    // TODO: Implement mail functionality
  }

  static void _handleCall() {
    // TODO: Implement call functionality
  }
}

class ContactOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ContactOptionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
      icon: Icon(icon, color: AppColors.primaryBackgroundColor),
      label: Text(
        label,
        style: const TextStyle(color: AppColors.primaryBackgroundColor),
      ),
      onPressed: onPressed,
    );
  }
}
