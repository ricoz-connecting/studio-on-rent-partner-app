import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/chip_selection.dart';

import 'widgets/custom_textfield.dart';

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            Center(
              child: Text(
                'Add Thumbnail',
                style: GoogleFonts.inter(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Studio Name*',
            ),
            const SizedBox(height: 20),
            Text(
              'Category',
              style: GoogleFonts.inter(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const ChipSelection(),
            const SizedBox(height: 20),
            const CustomTextField(
              keyboardType: TextInputType.multiline,
              hintText: 'About Studio',
            ),
          ],
        ),
      ),
    );
  }
}
