import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/add_image.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/feature/complains/views/widgets/previous_complaint.dart';
import 'package:studio_partner_app/utils/router.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Complaint',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Image.asset(
              'assets/images/Objects.png',
              height: 200,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Subject',
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'Warehouse Service',
                          child: Text('Warehouse Service')),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (value) {},
                    hint: Text(
                      'Select subject',
                      style: GoogleFonts.lato(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description',
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      hintText: 'Write description here....',
                      hintStyle: GoogleFonts.lato(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Add Image (Optional)',
                  ),
                  const SizedBox(height: 10),
                  const AddImage(),
                  const SizedBox(height: 10),
                  ReusableButton(
                    label: 'Submit Request',
                    onPressed: () {},
                    radius: 12,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter the details of your request. A member of support staff will respond as soon as possible.',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  PreviousCompaintWidgte(
                    onTap: () {
                      GoRouter.of(context).push(StudioRoutes.previousComplaint);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
