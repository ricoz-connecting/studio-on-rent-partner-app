import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studio_partner_app/src/feature/bookings/controller/bookings_controller.dart';

import 'widgets/service_card.dart';

class ActiveRequests extends ConsumerStatefulWidget {
  const ActiveRequests({super.key});

  @override
  ConsumerState<ActiveRequests> createState() => _ActiveRequestsState();
}

class _ActiveRequestsState extends ConsumerState<ActiveRequests> {
  bool isLoading = true;

  @override
  void initState() {
    _getBookings();
    super.initState();
  }

  Future<void> _getBookings() async {
    await ref.read(bookingsControllerProvider.notifier).getBookings();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            children: const [
              SizedBox(height: 20),
              ServiceCard(
                isComingFromActive: true,
                id: "12333",
                address: "123, XYZ Apt. New Delhi, Delhi, 123456",
                customerName: 'Shreya',
                daysLeft: '(19/30 Days)',
                nextBillingDate: '04/11/2023',
                studioName: 'Studio A',
                bookingStartDate: '31/08/2024',
                bookingEndDate: '31/10/2024',
                duration: '1 Month',
              ),
            ],
          );
  }
}
