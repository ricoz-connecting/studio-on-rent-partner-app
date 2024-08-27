import 'package:studio_partner_app/src/feature/Home/pages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ServiceCard extends StatelessWidget {
  final String id;
  final String serviceName;
  final String nextServiceDate;
  final String noOfPeople;
  final String address;
  final bool isBilling;

  const ServiceCard({
    super.key,
    required this.id,
    required this.serviceName,
    required this.nextServiceDate,
    required this.noOfPeople,
    required this.address,
    required this.isBilling,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Reduced elevation for a flatter look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Slightly smaller radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID: $id',
                  style: GoogleFonts.lato(
                    fontSize: 12, // Reduced font size
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // View Details action
                  },
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      color: AppColors.primaryBackgroundColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12, // Reduced font size
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Reduced spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  serviceName,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 14, // Reduced font size
                  ),
                ),
                Text(
                  isBilling
                      ? 'Next Billing On $nextServiceDate'
                      : nextServiceDate,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBackgroundColor,
                    fontSize: 12, // Reduced font size
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Reduced spacing
            const Divider(),
            const SizedBox(height: 8), // Reduced spacing
            Text(
              'Customer Details',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 12, // Reduced font size
              ),
            ),
            const SizedBox(height: 8), // Reduced spacing
            Text(
              'No of People: $noOfPeople',
              style: GoogleFonts.lato(
                fontSize: 12, // Reduced font size
              ),
            ),
            const SizedBox(height: 8), // Reduced spacing
            Text(
              'Address: $address',
              style: GoogleFonts.lato(
                fontSize: 12, // Reduced font size
              ),
            ),
            const SizedBox(height: 8), // Reduced spacing
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 16, // Reduced icon size
                ),
                label: const Text(
                  'Chat with Customer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12, // Reduced font size
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatScreen(),
                    ),
                  );
                  // Chat with Customer action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBackgroundColor,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10), // Reduced padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Reduced radius
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
