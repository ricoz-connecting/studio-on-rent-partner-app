import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Complaint',
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Image.asset(
              'assets/images/Objects.png', // Replace with your image asset path
              height: 200,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject*',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
                  Text(
                    'Description',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 4,
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
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.primaryBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        'Submit Request',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Table(
                    border: TableBorder.all(color: Colors.grey.shade300),
                    columnWidths: const {
                      0: FractionColumnWidth(0.1),
                      1: FractionColumnWidth(0.3),
                      2: FractionColumnWidth(0.4),
                      3: FractionColumnWidth(0.2),
                    },
                    children: [
                      _buildTableRow('4', 'Warehouse Service',
                          'Jan20,2024 4:45pm', 'Pending', Colors.red),
                      _buildTableRow('2', 'Other', 'Jan11,2024 4:45pm',
                          'Unsolved', Colors.blue),
                      _buildTableRow('2', 'Other', 'Jan1,2024 4:15pm', 'Solved',
                          AppColors.primaryBackgroundColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String number, String subject, String requested,
      String status, Color statusColor) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            number,
            style: GoogleFonts.lato(color: Colors.black, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            subject,
            style: GoogleFonts.lato(color: Colors.black, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            requested,
            style: GoogleFonts.lato(color: Colors.black, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            status,
            style: GoogleFonts.lato(
                color: statusColor, fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(home: ComplaintScreen()));
}
