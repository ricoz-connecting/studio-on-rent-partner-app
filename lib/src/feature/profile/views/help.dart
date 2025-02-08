import 'package:studio_partner_app/src/feature/complains/views/complain.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/contact_us_section.dart';
import 'package:studio_partner_app/src/feature/profile/views/widgets/custom_expension_tile.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Help',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: const [
                  CustomExpansionTile(
                    title: 'Services we offer',
                    content: 'Details about services we offer...',
                  ),
                  CustomExpansionTile(
                    title: 'How to get started with our services',
                    content: 'Details on how to get started...',
                  ),
                  CustomExpansionTile(
                    title: 'My Profile',
                    content: 'Details about your profile...',
                  ),
                  CustomExpansionTile(
                    title: 'Changes to project scope',
                    content: 'Information on project scope changes...',
                  ),
                  CustomExpansionTile(
                    title: 'Report & Invoices',
                    content: 'Details about reports and invoices...',
                  ),
                  CustomExpansionTile(
                    title: 'Support after the project completion',
                    content: 'Support information after project completion...',
                  ),
                  CustomExpansionTile(
                    title: 'Others',
                    content: 'Additional help topics...',
                  ),
                  ContactUsSection(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
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
                      builder: (context) => const ComplaintScreen(),
                    ),
                  );
                },
                child: const Text(
                  'RAISE TICKET',
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
    );
  }

  Widget _buildHelpOption(
    BuildContext context, {
    required String title,
    required Widget navigateTo,
    bool isLast = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      title: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
    );
  }
}

// Placeholder screens for navigation
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Services we offer')),
      body: const Center(child: Text('Services we offer details...')),
    );
  }
}

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('How to get started')),
      body: const Center(child: Text('How to get started details...')),
    );
  }
}

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('My Profile')),
//       body: const Center(child: Text('Profile details...')),
//     );
//   }
// }

class ProjectScopeScreen extends StatelessWidget {
  const ProjectScopeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Changes to project scope')),
      body: const Center(child: Text('Changes to project scope details...')),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report & Invoices')),
      body: const Center(child: Text('Report & Invoices details...')),
    );
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support after completion')),
      body: const Center(child: Text('Support details...')),
    );
  }
}

class OthersScreen extends StatelessWidget {
  const OthersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Others')),
      body: const Center(child: Text('Others details...')),
    );
  }
}

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: const Center(child: Text('Contact Us details...')),
    );
  }
}
