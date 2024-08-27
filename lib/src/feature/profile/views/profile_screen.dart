import 'package:studio_partner_app/src/feature/profile/views/widgets/bank_details.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/edit_profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/help.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/history_screen.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/sectionone.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/sectiontwo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 8),
            Text(
              'Profile',
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackgroundColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Hi, John',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    '+91 XXXXX XXXXX',
                    style: GoogleFonts.lato(color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SectionOne(),
              const SizedBox(height: 20),
              // Container for Address
              const SectionTwo(),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildProfileButton(
                    context,
                    Icons.help,
                    'Help',
                    onTap: () {
                      // Navigate to Help Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpPage()),
                      );
                    },
                  ),
                  _buildProfileButton(
                    context,
                    Icons.edit,
                    'Edit Profile',
                    onTap: () {
                      // Navigate to Edit Profile Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfile()),
                      );
                    },
                  ),
                  _buildProfileButton(
                    context,
                    Icons.history,
                    'History',
                    onTap: () {
                      // Navigate to History Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryPage()),
                      );
                    },
                  ),
                  _buildProfileButton(
                    context,
                    Icons.account_balance_wallet,
                    'Bank Details',
                    onTap: () {
                      // Navigate to Bank Details Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BankDetails()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.black),
                title: Text(
                  'Logout',
                  style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  // Handle logout action
                },
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.black),
              ),
              const SizedBox(height: 15),
              TextButton.icon(
                icon: const Icon(Icons.delete_forever, color: Colors.red),
                label: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Delete Account',
                    style: GoogleFonts.lato(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                ),
                onPressed: () {
                  // Handle delete account action
                },
              ),
              const SizedBox(height: 20), // Added extra space at the bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, IconData icon, String label,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 29, color: Colors.black),
            const SizedBox(height: 9),
            Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: ProfileScreen()));
}
