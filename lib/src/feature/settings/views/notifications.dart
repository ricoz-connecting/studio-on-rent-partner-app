import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class NotificationsCard extends StatefulWidget {
  final String label;
  bool value;
  NotificationsCard({
    required this.value,
    required this.label,
    super.key,
  });

  @override
  State<NotificationsCard> createState() => _NotificationsCardState();
}

class _NotificationsCardState extends State<NotificationsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Text(
              widget.label,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const Spacer(),
          Switch(
              value: widget.value,
              onChanged: (value) {
                setState(() {
                  widget.value = value;
                });
              }),
        ],
      ),
    );
  }
}
