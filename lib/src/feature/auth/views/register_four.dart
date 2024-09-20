import 'package:studio_partner_app/src/feature/auth/views/verification.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/upload_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class RegisterFour extends StatelessWidget {
  const RegisterFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Upload documents for verification',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.article_outlined, color: Colors.black),
                ),
                hint: const Text('Select document'),
                items: const [
                  DropdownMenuItem(value: 'ID', child: Text('ID')),
                  DropdownMenuItem(value: 'Passport', child: Text('Passport')),
                  DropdownMenuItem(value: 'License', child: Text('License')),
                ],
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.confirmation_number_outlined,
                    color: Colors.black),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 14,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Document No.',
                hintStyle: TextStyle(color: Colors.grey.shade500),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Upload Documents',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildUploadButton(context, 'Front'),
                buildUploadButton(context, 'Back'),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor:
                        index == 3 ? Colors.black : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBackgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Verification(),
                    ),
                  );
                },
                child: const Text(
                  'CONTINUE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
