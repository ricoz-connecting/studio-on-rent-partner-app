import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/bookings/views/studio_details.dart';
import 'package:studio_partner_app/src/models/bookings.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ServiceCard extends StatelessWidget {
  final Booking? booking;
  final bool isComingFromActive;

  const ServiceCard({
    super.key,
    this.booking,
    required this.isComingFromActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF4F6F9),
      elevation: 1,
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
                CircleAvatar(
                  backgroundImage: NetworkImage(booking!.partnerDetails.avatar),
                  radius: 24,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking!.customerDetails.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ID : ${booking!.orderId}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StudioDetail(
                        booking: booking!,
                      );
                    }));
                  },
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Day's Left",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '(19/30 Days)',
                      style: TextStyle(
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
                    const Text(
                      '04/11/2023',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 32),
            Row(
              children: [
                Image.network(
                  booking!.studioDetails.thumbnail,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking!.studioDetails.studioName,
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
                            Text(booking!.bookingDetails.startTime),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Booking Ends on: '),
                            const Spacer(),
                            Text(booking!.bookingDetails.endTime),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Duration: '),
                            const Spacer(),
                            Text(
                                "${booking!.paymentDetails.duration.value} ${booking!.paymentDetails.duration.title}"),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
            const Divider(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Address',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  textAlign: TextAlign.end,
                  booking!.studioDetails.address,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
