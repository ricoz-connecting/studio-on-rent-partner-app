import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/src/feature/addstudio/views/widgets/add_image.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/feature/complains/controller/complaint_controller.dart';
import 'package:studio_partner_app/src/feature/complains/controller/previous_complaint_controller.dart';
import 'package:studio_partner_app/src/feature/complains/views/widgets/previous_complaint.dart';
import 'package:studio_partner_app/src/feature/file/controller/file_controller.dart';
import 'package:studio_partner_app/utils/router.dart';

class ComplaintScreen extends ConsumerStatefulWidget {
  const ComplaintScreen({super.key});

  @override
  ConsumerState<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends ConsumerState<ComplaintScreen> {
  File? _selectedFile;
  String? subject;
  final TextEditingController _complaintController = TextEditingController();
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
              height: MediaQuery.of(context).size.height * 0.2,
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
                    value: subject,
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
                          value: 'Studio Service',
                          child: Text('Studio Service')),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        subject = value;
                      });
                    },
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
                    controller: _complaintController,
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
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onChanged: (value) {
                      setState(() {
                        _complaintController.text = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Add Image (Optional)',
                  ),
                  const SizedBox(height: 10),
                  AddImage(
                    onTap: () async {
                      final file =
                          await ref.read(fileControllerProvider).selectFile();
                      setState(() {
                        _selectedFile = file;
                      });
                    },
                    image: _selectedFile,
                  ),
                  const SizedBox(height: 10),
                  ReusableButton(
                    label: 'Submit Request',
                    onPressed: () {
                      ref
                          .read(complaintControllerProvider.notifier)
                          .addComplaint(
                            context: context,
                            title: subject ?? '',
                            description: _complaintController.text,
                            file: _selectedFile,
                          );
                    },
                    radius: 12,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter the details of your request. A member of support staff will respond as soon as possible.',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  PreviousCompaintWidget(
                    onTap: () {
                      final currentUser = ref.watch(currentUserProvider);
                      ref
                          .read(previousComplaintControllerProvider.notifier)
                          .getComplaintDetails(currentUser!.id);
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
