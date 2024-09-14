import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
