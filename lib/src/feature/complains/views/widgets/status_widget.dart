import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StatusWidget extends StatelessWidget {
  final String status;
  final String sno;
  final String subject;
  final DateTime isoDate;
  const StatusWidget({
    required this.isoDate,
    required this.subject,
    required this.status,
    required this.sno,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = isoDate;
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(parsedDate);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$sno. ",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                status,
                style: GoogleFonts.poppins(
                  color: status == 'Pending'
                      ? Colors.red
                      : status == 'Unsolved'
                          ? Colors.blue
                          : Colors.green,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
