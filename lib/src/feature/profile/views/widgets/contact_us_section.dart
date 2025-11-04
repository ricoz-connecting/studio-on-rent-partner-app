import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsSection extends StatelessWidget {
  const ContactUsSection({super.key});
  Future<void> _launchDialer({required String phoneNumber}) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch dialer';
    }
  }

  Future<void> _handleMail({required String email}) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print("Could not launch mail client");
    }
  }

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
            children: [
              ContactOptionButton(
                icon: Icons.mail,
                label: 'Mail Us',
                onPressed: () => _handleMail(email: "care@bookmystudio.app"),
              ),
              GestureDetector(
                onTap: () => _launchDialer(phoneNumber: '1234567890'),
                child: ContactOptionButton(
                  icon: Icons.phone,
                  label: 'Call Us',
                  onPressed: () => _launchDialer(phoneNumber: '1234567890'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
