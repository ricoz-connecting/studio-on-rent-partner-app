import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/auth/views/widgets/reusable_button.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ServiceCard extends StatelessWidget {
  final bool isComingFromActive;
  final String customerName;
  final String id;
  final String daysLeft;
  final String nextBillingDate;
  final String studioName;
  final String bookingStartDate;
  final String bookingEndDate;
  final String duration;
  final String address;

  const ServiceCard({
    super.key,
    required this.isComingFromActive,
    required this.customerName,
    required this.id,
    required this.daysLeft,
    required this.nextBillingDate,
    required this.studioName,
    required this.bookingStartDate,
    required this.bookingEndDate,
    required this.duration,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF4F6F9),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profile.png'),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ID : $id',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      color: AppColors.primaryBackgroundColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Day's Left",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      daysLeft,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBackgroundColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isComingFromActive ? 'Next Billings on' : 'Total Paid',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      nextBillingDate,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 32),
            Row(
              children: [
                Image.asset(
                  'assets/images/frame.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studioName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Booking Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('Booking Starts on: '),
                          const Spacer(),
                          Text(bookingStartDate),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Booking Ends on: '),
                          const Spacer(),
                          Text(bookingEndDate),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Duration: '),
                          const Spacer(),
                          Text(duration),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Address',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      address,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: (AppColors.primaryBackgroundColor),
                minimumSize: const Size(double.infinity, 36),
                shadowColor: Colors.black.withOpacity(0.2),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Chat with Customer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
