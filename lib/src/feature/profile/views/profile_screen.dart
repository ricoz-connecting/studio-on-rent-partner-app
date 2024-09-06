import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/profile/models/profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/bank_details.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/custom_edit_profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/edit_profile.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/help.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/history_screen.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/sectionone.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/sectiontwo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';
import '../controllers/logout.dart';

class ProfileScreen extends ConsumerWidget {
  final Profile profile;

  const ProfileScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context, ref) {
    // log('${profile.avatar}');
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
                      backgroundImage: profile.avatar == ''
                          ? null
                          : NetworkImage(
                              '${profile.avatar}',
                            )),
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
                'Hi, ${profile.name}',
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
                  const Icon(Icons.phone_outlined, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    profile.phone!,
                    style: GoogleFonts.lato(color: Colors.black54),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SectionOne(
                businessName: profile.businessName!,
              ),
              const SizedBox(height: 20),
              SectionTwo(
                city: profile.city!,
                state: profile.state!,
                address: profile.address!,
              ),
              const SizedBox(height: 20),
              CustomEditProfile(
                  label: "Customer Reviews",
                  icon: Icons.reviews_outlined,
                  onTap: () {}),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildProfileButton(
                    context,
                    Icons.help_outline_outlined,
                    'Help',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpPage()),
                      );
                    },
                  ),
                  _buildProfileButton(
                    context,
                    Icons.edit_outlined,
                    'Edit Profile',
                    onTap: () {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HistoryPage()),
                      );
                    },
                  ),
                  _buildProfileButton(
                    context,
                    Icons.account_balance_wallet_outlined,
                    'Bank Details',
                    onTap: () {
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
              CustomEditProfile(
                label: 'KYC',
                icon: Icons.event_note_outlined,
                onTap: () {},
              ),
              const SizedBox(height: 15),
              CustomEditProfile(
                label: 'Logout',
                icon: Icons.logout,
                onTap: () {
                  Logout.logout(context);
                },
              ),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.grey.shade100,
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(color: Colors.grey.shade300),
              //   ),
              //   child: TextButton.icon(
              //     icon: const Icon(Icons.delete_forever_outlined,
              //         color: Colors.red),
              //     label: Align(
              //       alignment: Alignment.bottomLeft,
              //       child: Text(
              //         'Delete Account',
              //         style: GoogleFonts.lato(
              //             color: Colors.red, fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //     onPressed: () {},
              //   ),
              // ),
              const SizedBox(height: 20),
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
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 29,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.lato(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
