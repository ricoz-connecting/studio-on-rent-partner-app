import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildUploadButton(BuildContext context, String label) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.add_photo_alternate_outlined,
              size: 40,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: GoogleFonts.lato(fontSize: 14)),
      ],
    );
  }
