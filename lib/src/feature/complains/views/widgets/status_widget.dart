import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusWidget extends StatelessWidget {
  final String status;
  final String sno;
  const StatusWidget({
    required this.status,
    required this.sno,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    'Studio Service',
                    style: GoogleFonts.lato(fontSize: 18),
                  ),
                  const Text('Jan 20, 2024 04:45pm'),
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
