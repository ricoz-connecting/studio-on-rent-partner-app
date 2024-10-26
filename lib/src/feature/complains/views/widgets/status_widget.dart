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
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(sno),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: GoogleFonts.lato(fontSize: 18),
                  ),
                  Text(formattedDate),
                ],
              ),
              const Spacer(),
              Text(
                status,
                style: GoogleFonts.lato(
                    color: status == 'Pending'
                        ? Colors.red
                        : status == 'Unsolved'
                            ? Colors.blue
                            : Colors.green),
              ),
            ],
          )
        ],
      ),
    );
  }
}
