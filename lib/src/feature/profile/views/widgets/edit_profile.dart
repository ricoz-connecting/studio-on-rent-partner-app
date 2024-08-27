import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          textAlign: TextAlign.left,
          'Edit Profile',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          // Add edit profile picture logic here
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      hintText: 'John Doe',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      hintText: '+91 XXXXXX XXXXX',
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'Restaurant Name',
                      hintText: 'ABC XYZ Restaurant',
                      prefixIcon: Icons.restaurant,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      label: 'Restaurant Address',
                      hintText: '111, ABC Apartments',
                      prefixIcon: Icons.location_city,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      hintText: 'XYZ Road, New Delhi',
                      prefixIcon: Icons.location_on,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      hintText: 'Delhi',
                      prefixIcon: Icons.map,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  AppColors.primaryBackgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Add save logic here
                  },
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    String? label,
    required String hintText,
    IconData? prefixIcon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.black)
                : null,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(home: EditProfile()));
}
