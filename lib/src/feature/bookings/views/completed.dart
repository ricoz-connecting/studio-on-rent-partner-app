import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/feature/bookings/views/widgets/service_card.dart';

class CompletedRequests extends StatefulWidget {
  const CompletedRequests({super.key});

  @override
  State<CompletedRequests> createState() => _CompletedRequestsState();
}

class _CompletedRequestsState extends State<CompletedRequests> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      children: const [
        SizedBox(height: 20),
        ServiceCard(
          isComingFromActive: false,
          id: "12333",
          address: "123, XYZ Apt. New Delhi, Delhi, 123456",
          customerName: 'Shreya',
          daysLeft: 'Completed',
          nextBillingDate: '\$550',
          studioName: 'Studio A',
          bookingStartDate: '31/08/2024',
          bookingEndDate: '31/10/2024',
          duration: '1 Month',
        ),
      ],
    );
  }
}
