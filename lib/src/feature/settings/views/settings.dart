import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/settings/views/notifications.dart';

import 'widgets/settings_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SettingsCard(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()));
            },
            icon: Icons.notifications_outlined,
            label: "Notifications",
          ),
          SettingsCard(
            onTap: () {},
            icon: Icons.person_outlined,
            label: "Invite a Friend",
          ),
          SettingsCard(
            onTap: () {},
            icon: Icons.person_outlined,
            label: "Terms of Service",
          ),
          SettingsCard(
            onTap: () {},
            icon: Icons.person_outlined,
            label: "Help and Support",
          ),
          SettingsCard(
            onTap: () {},
            icon: Icons.person_outlined,
            label: "Privacy policy",
          ),
          SettingsCard(
            onTap: () {},
            icon: Icons.person_outlined,
            label: "About Us",
          ),
          SettingsCard(
            onTap: () {},
            icon: Icons.person_outlined,
            label: "Feedback",
          ),
          SettingsCard(
            onTap: () {},
            icon: Icons.logout,
            label: "Logout",
          ),
        ],
      ),
    );
  }
}
