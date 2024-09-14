import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/notification_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  final bool isNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications Settings',
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationsCard(
              value: isNotification,
              label: 'Enable Notifications',
            ),
            const SizedBox(height: 20),
            Text(
              'Notification Preferences',
              style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            NotificationsCard(
              value: isNotification,
              label: 'Receive notifications for new messages',
            ),
            const SizedBox(height: 20),
            NotificationsCard(
              value: isNotification,
              label: 'Receive notifications for friend requests',
            ),
            const SizedBox(height: 20),
            NotificationsCard(
              value: isNotification,
              label: 'Receive notifications for updates in communities',
            ),
            const SizedBox(height: 20),
            NotificationsCard(
              value: isNotification,
              label: 'Receive notifications for upcoming events',
            ),
            const SizedBox(height: 20),
            NotificationsCard(
              value: isNotification,
              label: 'Receive notifications for new followers',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

